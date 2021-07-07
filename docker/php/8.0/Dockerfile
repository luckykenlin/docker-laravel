# Installs MySQL Client for database exports

FROM php:8.0-fpm-alpine
WORKDIR /app

# Install nginx, MySQL Dump for automated backups and other dependencies
RUN apk add --no-cache mariadb-client postgresql postgresql-dev zip libzip-dev ; \
	docker-php-ext-configure zip ; \
	docker-php-ext-install bcmath pdo_mysql pdo_pgsql zip ;
