#!/bin/bash

if [ $# -ne 1 ] ; then
    OVPN_PATH="/srv/openvpn"
else
    OVPN_PATH=$1
fi

rm $OVPN_PATH/openvpn.conf
rm -r $OVPN_PATH/client
rm -r $OVPN_PATH/otp




