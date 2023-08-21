FROM php:8.2-fpm as php-base

ENV TZ=Asia/Tokyo COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    zip \
    unzip \
    vim \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libzip-dev \
    && apt-get clean \
    && pecl install redis \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure zip \
    && docker-php-ext-install \
    gd \
    exif \
    opcache \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    pcntl \
    zip \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*;

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add UID '1000' to www-data
RUN usermod -u 1000 www-data

# www-data is default user for php
RUN chown -R www-data:www-data /var/www/html

COPY app/config/php.ini /usr/local/etc/php

USER root

COPY app/config/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
