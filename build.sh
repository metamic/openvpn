#!/bin/bash

if [ $# -ne 0 ]; then
    echo "$0"
    exit 0
fi

docker build -t metamic/openvpn:latest .
