#!/bin/bash

IPprefix_by_netmask () { 
    c=0 x=0$( printf '%o' ${1//./ } )
    while [ $x -gt 0 ]; do
        let c+=$((x%2)) 'x>>=1'
    done
    return $c
}
   
# make tun device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi

# import env
OVPN_NETMASK="255.255.255.0"
OVPN_SUBNET="172.100.100.0"
if [ -f "/etc/openvpn/tmp/ovpn_config.sh" ] ; then
    source "/etc/openvpn/tmp/ovpn_config.sh"
fi

# convert ip prefix to netmask
IPprefix_by_netmask $OVPN_NETMASK
NN=$?

# configure iptables
iptables -t nat -A POSTROUTING -s $OVPN_SUBNET/$NN -o eth0 -j MASQUERADE    # subnet

# restore user
cat /etc/openvpn/users/passwd   >> /etc/passwd
cat /etc/openvpn/users/group    >> /etc/group
cat /etc/openvpn/users/shadow   >> /etc/shadow
cat /etc/openvpn/users/gshadow  >> /etc/gshadow

# run openvpn server
/usr/sbin/openvpn --config /etc/openvpn/openvpn.conf

