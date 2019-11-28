#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 <version>"
    exit 0
fi

docker push metamic/openvpn:latest
docker tag metamic/openvpn:latest metamic/openvpn:$1
docker push metamic/openvpn:$1