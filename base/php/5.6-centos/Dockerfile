FROM centos:7
MAINTAINER Jacky Zhang <myself.fervor@gmail.com>

ADD rootfs.tar.gz /

COPY docker-php-entrypoint /usr/local/bin/

RUN set -xe \
    && mkdir -p /data \
    && yum install -y epel-release \
    \
    && yum makecache \
    \
    && yum install -y gcc gcc-c++ make \
            gd-devel \
            libcurl-devel \
            libxml2-devel \
            libmcrypt-devel \
            libxml2-devel \
            libmemcached-devel \
            openssl-devel \
            ImageMagick-devel \
            bzip2-devel \
            libicu-devel \
            libxslt-devel \
            readline-devel \
            re2c \
            file \
            autoconf \
            automake \
    && yum clean all \
    \
    && groupadd -g 802 www \
    && useradd -g 802 -d /data/wwwroot www \
    \
    && cd /usr/src \
    && curl -L http://192.168.100.230:3001/5.6/php-5.6.18.tar.gz -o php-5.6.18.tar.gz \
    && tar xzf php-5.6.18.tar.gz \
    && cd php-5.6.18 \
    && ./configure --prefix=/data/server/php-5.6.18 \
        --with-config-file-path=/data/etc/php/5.6 \
        --with-config-file-scan-dir=/data/etc/php/5.6/extra \
        --with-mysql=mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-gettext \
        --with-bz2 \
        --enable-calendar \
        --enable-intl \
        --with-readline \
        --with-iconv-dir \
        --with-zlib \
        --with-xsl \
        --enable-xml \
        --enable-bcmath \
        --enable-shmop \
        --enable-sysvsem \
        --enable-sysvmsg \
        --enable-sysvshm \
        --enable-inline-optimization \
        --with-curl \
        --enable-mbregex \
        --enable-ftp \
        --enable-fpm \
        --enable-json \
        --enable-mbstring \
        --with-mcrypt \
        --with-gd \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-png-dir \
        --enable-exif \
        --enable-gd-native-ttf \
        --with-openssl \
        --with-mhash \
        --with-libxml-dir \
        --enable-sockets \
        --enable-zip \
        --enable-soap \
        --enable-pcntl \
        --enable-wddx \
    && make -j2 && make install \
    \
    && cd /usr/src && rm -rf php-5.6.18.tar.gz php-5.6.18 \
    \
    && cd /data/server/ \
    && ln -sfn php-5.6.18 php \
    && ln -sfn /data/etc/php/5.6/php-fpm.conf /data/server/php/etc/php-fpm.conf \
    && ln -sfn /data/server/php/bin/{phar,php,phpize,php-cgi,php-config} /usr/bin/ \
    \
    && ln -sfn /data/server/php/sbin/php-fpm /usr/bin/ \
    \
    && cd /usr/src \
    \
    && curl -L http://192.168.100.230:3001/5.6/extension.tar.gz -o extension.tar.gz && tar xzf extension.tar.gz && rm -rf extension.tar.gz \
    \
    && cd /usr/src/extension/memcache-2.2.7 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/memcached-2.2.0 \
        && phpize \
        && ./configure --disable-memcached-sasl \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/redis-2.2.8 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/mongo-1.6.10 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/xhprof-0.9.4/extension \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/cphalcon-3.1.2/build \
        && ./install \
    \
    && cd /usr/src/extension/swoole-src-1.9.11 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/yar-1.2.5 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/msgpack-0.5.7 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/igbinary-1.2.1 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src/extension/imagick-3.4.3 \
        && phpize \
        && ./configure \
        && make -j2 && make install && make clean \
    \
    && cd /usr/src && rm -rf extension \
    \
    && yum remove -y gcc gcc-c++ make \
            re2c \
            file \
            autoconf \
            automake

VOLUME ["/data/wwwroot/", "/data/etc/", "/data/logs/"]

ENTRYPOINT ["docker-php-entrypoint"]

EXPOSE 9000
CMD ["php-fpm", "--nodaemonize"]
