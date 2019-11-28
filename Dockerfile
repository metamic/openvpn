FROM ubuntu:16.04
MAINTAINER meta.microcode@gmail.com

RUN apt-get -y -qq update
RUN apt-get install -y -qq net-tools openvpn easy-rsa iptables-persistent libpam-google-authenticator
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

WORKDIR /

COPY ./init/run.sh /run.sh
COPY ./init/client.ovpn /client.ovpn
COPY ./init/openvpn.conf /openvpn.conf 
COPY ./init/ovpn_table.conf /ovpn_table.conf 

COPY ./pam/gotp /etc/pam.d/gotp
COPY ./pam/login_gotp /etc/pam.d/login_gotp

COPY ./bin/ovpn_genconfig /bin/ovpn_genconfig
COPY ./bin/ovpn_addroute /bin/ovpn_addroute
COPY ./bin/ovpn_delroute /bin/ovpn_delroute
COPY ./bin/ovpn_initpki /bin/ovpn_initpki
COPY ./bin/ovpn_mkclient /bin/ovpn_mkclient
COPY ./bin/ovpn_opt /bin/ovpn_opt
COPY ./bin/ovpn_otpuser /bin/ovpn_otpuser
COPY ./bin/ovpn_adduser /bin/ovpn_adduser
COPY ./bin/ovpn_deluser /bin/ovpn_deluser

RUN chmod 755 /run.sh
RUN chmod 755 /bin/ovpn_genconfig
RUN chmod 755 /bin/ovpn_addroute
RUN chmod 755 /bin/ovpn_delroute
RUN chmod 755 /bin/ovpn_initpki
RUN chmod 755 /bin/ovpn_mkclient
RUN chmod 755 /bin/ovpn_opt
RUN chmod 755 /bin/ovpn_otpuser
RUN chmod 755 /bin/ovpn_adduser
RUN chmod 755 /bin/ovpn_deluser


EXPOSE 1194/udp
CMD "/run.sh"