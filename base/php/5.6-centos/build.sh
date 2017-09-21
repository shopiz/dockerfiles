#!/bin/sh

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 version"
    exit 255
fi

VERSION=$1

cd rootfs && tar czf ../rootfs.tar.gz . && cd ..

docker build --no-cache -t php:5.6-centos7-${VERSION} --rm .

docker tag php:5.6-centos7-${VERSION} registry.weicheche.cn/library/php:5.6-centos7-${VERSION}

docker login -u baolin -p 123qweA registry.weicheche.cn 2>&1 > /dev/null

docker push registry.weicheche.cn/library/php:5.6-centos7-${VERSION}

docker rmi registry.weicheche.cn/library/php:5.6-centos7-${VERSION}

rm -rf rootfs.tar.gz
