FROM php:5.6-fpm-alpine
MAINTAINER Jacky Zhang <myself.fervor@gmail.com>

ENV PHPIZE_DEPS \
                autoconf \
                file \
                g++ \
                gcc \
                libc-dev \
                make \
                pkgconf \
                re2c \
                zlib-dev \
                openssl-dev \
                cyrus-sasl-dev \
                libaio-dev

ADD src/etc/php/conf.d/ /usr/local/etc/php/conf.d

ADD src/etc/php/fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN set -xe \
        && { \
            echo 'http://mirrors.ustc.edu.cn/alpine/v3.4/main/'; \
            echo 'http://mirrors.ustc.edu.cn/alpine/v3.4/community/'; \
        } | tee /etc/apk/repositories \
        \
        && apk add --no-cache --virtual .build-deps \
                $PHPIZE_DEPS \
        \
        && apk add --no-cache \
            libmemcached-dev \
            php5-opcache \
            php5-curl \
            php5-json \
            php5-sysvsem \
            php5-mysql php5-mysqli \
            php5-pdo php5-pdo_mysql \
            php5-openssl \
            php5-gd \
            php5-gettext \
            php5-mcrypt \
            php5-iconv \
            php5-sockets \
            php5-bz2 \
            php5-bcmath \
            php5-pcntl \
            php5-memcache \
            php5-phalcon \
        \
        && cd /usr/src \
        \
        && wget http://192.168.100.230:3001/extension.tar.gz && tar xzf extension.tar.gz && rm -rf extension.tar.gz \
        \
        && cd extension \
            && cd memcached-2.2.0 \
                && phpize \
                && ./configure --disable-memcached-sasl \
                && make -j4 && make install && make clean \
            \
            && cd ../redis-3.1.0 \
                && phpize \
                && ./configure \
                && make -j4 && make install && make clean \
            \
            && cd ../mongo-1.6.10 \
                && phpize \
                && ./configure \
                && make -j4 && make install && make clean \
            \
            && cd ../xhprof-0.9.4/extension \
                && phpize \
                && ./configure \
                && make -j4 && make install && make clean; cd ../../ \
            \
            && rm -rf /usr/src/extension \
       \
       && apk del .build-deps && unset $PHPIZE_DEPS

# ensure www user exists
RUN set -x \
	&& addgroup -g 802 -S www \
	&& adduser -u 802 -D -S -G www www \
	\
	&& mkdir -p /data/logs/php-fpm && chown www.www /data/logs/php-fpm

VOLUME ["/data/wwwroot/", "/data/etc/", "/data/logs/"]
