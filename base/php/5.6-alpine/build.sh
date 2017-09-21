#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 version"
    exit 255
fi

VERSION=$1

docker build --no-cache -t php:5.6-fpm-alpine-${VERSION} --rm .

docker tag php:5.6-fpm-alpine-${VERSION} registry.weicheche.cn/library/php:5.6-fpm-alpine-${VERSION}

docker push registry.weicheche.cn/library/php:5.6-fpm-alpine-${VERSION}

docker rmi registry.weicheche.cn/library/php:5.6-fpm-alpine-${VERSION}
