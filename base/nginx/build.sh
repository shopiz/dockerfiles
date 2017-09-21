#!/bin/sh

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 version"
    exit 255
fi

NGINX_VERSION=1.13
VERSION=$1

cd rootfs && tar czf ../rootfs.tar.gz . && cd ..

docker build --no-cache -t nginx:${NGINX_VERSION}-alpine-${VERSION} .

docker tag nginx:${NGINX_VERSION}-alpine-${VERSION} registry.shopiz.cn/library/nginx:${NGINX_VERSION}-alpine-${VERSION}

docker push registry.shopiz.cn/library/nginx:${NGINX_VERSION}-alpine-${VERSION}

rm -rf rootfs.tar.gz

