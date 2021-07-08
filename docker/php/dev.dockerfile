# DOCKERFILE DEVELOPMENT
# Installs MySQL Client for database exports, xDebug with PCov and Composer

FROM php:7.4-fpm
WORKDIR /app

RUN apt-get update && apt-get install -y \
    zip \
    git \
    mariadb-client \
    autoconf \
    build-essential \
    libpq-dev \
    libzip-dev \
    autoconf \
    gcc \
    g++ \
    make

RUN pecl install xdebug pcov redis
RUN docker-php-ext-install bcmath pdo_mysql pdo_pgsql zip pcntl
RUN docker-php-ext-enable xdebug pcov redis

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
