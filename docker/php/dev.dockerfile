# Installs MySQL Client for database exports

FROM php:8.2-fpm-alpine
WORKDIR /app

# Install nginx, reids, MySQL Dump for automated backups and other dependencies
RUN apk update
RUN apk add --no-cache mariadb-client postgresql postgresql-dev zip libzip-dev autoconf gcc g++ make; \
	docker-php-ext-configure zip ; \
	docker-php-ext-install pcntl bcmath pdo_mysql pdo_pgsql zip ;

RUN pecl install redis pcov
RUN docker-php-ext-enable redis pcntl pcov

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer