FROM php:8.2-fpm-alpine as php-base

ENV TZ=Asia/Tokyo COMPOSER_ALLOW_SUPERUSER=1

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# www-data is default user for php
RUN chown -R www-data:www-data /var/www/html

COPY app/config/php.ini /usr/local/etc/php

USER www-data

COPY --chown=www-data app/config/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
