# OpenVPN for Docker

## Feature
- Support traffic option
- Support setting route
- Support login
- Support OTP
- Support Two-Factor Authentication

## Usage
1. Routing Configure in Dockerized OpenVPN. If you don't need routing you can skip this step.
2. Choose authtication options
3. Initialize pki
4. Create client
5. Create Authenticaiton
6. Create Dockerized OpenVPN Server

- Add VPN route
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_addroute -n 172.31.16.0 -m 255.255.240.0
```


- If you want to pass all traffic via your VPN Server, Enable all traffic passes via this VPN
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_addroute -a def1
```

- Delete VPN route
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_delroute -n 172.31.16.0 -m 255.255.240.0
```

- Disable all traffic passes via this VPN
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_delroute -a def1
```

- Set option
If you enable login_otp then you can use [password] + [otp 6 digits]. 
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_opt -e login
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_opt -e otp
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_opt -e login_otp
```

- Finally, you can make openvpn config file
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_genconfig -u <your_ip_address> -n 172.100.10.0 -m 255.255.255.0
```

- initialize pki use easyrsa for authenticate 
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_initpki
```

- make client ovpn included authentication
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_mkclient user
```

- if you use login authentication you can make linux user and delete user
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_adduser user
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_deluser user
```

- if you use otp authentication you needs otp user
```
docker run -it -v /srv/openvpn:/etc/openvpn --rm metamic/openvpn ovpn_otpuser user

```

- you can make Dockerized OpenVPN Server
```
docker run -d --restart always -v /srv/openvpn:/etc/openvpn -p 1194:1194/udp --cap-add=NET_ADMIN -v /etc/localtime:/etc/localtime:ro --name openvpn metamic/openvpn
```

- if you use time-based OTP you needs this options
```
-v /etc/localtime:/etc/localtime:ro
```

- and you can check docker time
```
date
docker exec -it openvpn date
```

if you already set openvpn you can remove the openvpn container.
```
docker stop openvpn && docker rm openvpn
```

you can see dockerized OpenVPN logs
```
docker logs -f openvpn
```

# References
- https://github.com/kylemanna/docker-openvpn
