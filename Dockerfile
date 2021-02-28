FROM php:5-cli AS builder

RUN apt update && \
    apt install -y unzip

ADD https://getcomposer.org/installer /tmp
RUN php /tmp/installer && mv composer.phar /usr/local/bin/composer

COPY . /opt
WORKDIR /opt

RUN composer install

FROM php:5-cli AS runner

RUN apt update && \
    apt install -y libmagick++-dev && \
    yes '' | pecl install imagick && \
    docker-php-ext-install mbstring && \
    docker-php-ext-enable imagick mbstring

EXPOSE 8000

WORKDIR /opt
COPY --from=builder /opt /opt

USER www-data

ENTRYPOINT [ "php", "-S", "0.0.0.0:8000", "esc2html.php" ]
