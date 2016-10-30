FROM php:7-apache
ADD blog-site /var/www/html/
ADD blog-site/.htaccess /var/www/html/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        pkg-config && \
    chown www-data:www-data -R /var/www/html && \
    docker-php-ext-install -j$(nproc) mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install -j$(nproc) zip && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*
