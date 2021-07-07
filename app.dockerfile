# DOCKERFILE RELEASE

# ================================
# PHP Dependency Setup
FROM composer AS builder
WORKDIR /app

# Make needed parts of the app available in the container
COPY ./app /app/app
COPY ./bootstrap /app/bootstrap
COPY ./config /app/config
COPY ./database /app/database
COPY ./resources /app
COPY ./routes /app/routes
COPY ./storage /app/storage
COPY ./tests /app/tests

COPY ["./artisan", "./composer.json", "./README.md", "./server.php", "/app/"]
COPY ./.env.production /app/.env

# Install dependencies using Composer
RUN composer install -n --prefer-dist --no-dev

# ================================
# Compile all assets
FROM node:14 AS npm_builder
WORKDIR /srv

COPY ./resources ./resources
COPY ["./package.json", "./webpack.mix.js", "/srv/"]

RUN npm install
RUN npm run production

# ================================
# Prepare the final image
FROM luckykenlin/php
WORKDIR /app

# Copy the app into the container
COPY ./app /app/app
COPY ./bootstrap /app/bootstrap
COPY ./config /app/config
COPY ./database /app/database
COPY ./public /app/public
COPY ./resources /app/resources
COPY ./routes /app/routes
COPY ./storage /app/storage
COPY ./tests /app/tests

COPY ["./artisan", "./composer.json", "./README.md", "./package.json", "./server.php", "/app/"]
COPY ./.env.production /app/.env

# Copy the PHP and nginx config files
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# Copy files from the composer build
COPY --from=builder /app/vendor /app/vendor
COPY --from=builder /app/bootstrap/cache /app/bootstrap/cache

# Copy files from the theme build
COPY --from=npm_builder /srv/public/ /app/public/

# Set correct permissions for the storage directory
RUN chmod -R 0777 /app/storage
