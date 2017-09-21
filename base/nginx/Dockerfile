FROM nginx:1.13-alpine
MAINTAINER Jacky Zhang <myself.fervor@gmail.com>

ADD rootfs.tar.gz /

RUN set -xe \
        && apk add --no-cache \
            nginx-mod-http-lua

# ensure www user exists
RUN set -x \
	&& addgroup -g 802 -S www \
	&& adduser -u 802 -D -S -G www www \
	&& chown nginx.nginx /var/lib/nginx \
        && ln -sfn /data/etc/nginx/* /etc/nginx/

VOLUME ["/data/wwwroot/", "/data/etc/", "/data/logs/"]