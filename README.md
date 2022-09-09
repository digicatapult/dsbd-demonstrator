# DSBD Demonstrator

## Installation Prerequisites

### Raspberry pi

```# deinstall classic networking
pi@raspberrypi:~ $ sudo -Es   # if not already done
root@raspberrypi:~ # systemctl daemon-reload
root@raspberrypi:~ # systemctl disable --now ifupdown dhcpcd dhcpcd5 isc-dhcp-client isc-dhcp-common rsyslog
root@raspberrypi:~ # apt --autoremove purge ifupdown dhcpcd dhcpcd5 isc-dhcp-client isc-dhcp-common rsyslog
root@raspberrypi:~ # rm -r /etc/network /etc/dhcp

# setup/enable systemd-resolved and systemd-networkd
root@raspberrypi:~ # systemctl disable --now avahi-daemon libnss-mdns
root@raspberrypi:~ # apt --autoremove purge avahi-daemon
root@raspberrypi:~ # apt install libnss-resolve
root@raspberrypi:~ # ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
root@raspberrypi:~ # apt-mark hold avahi-daemon dhcpcd dhcpcd5 ifupdown isc-dhcp-client isc-dhcp-common libnss-mdns openresolv raspberrypi-net-mods rsyslog
root@raspberrypi:~ # systemctl enable systemd-networkd.service systemd-resolved.service
root@raspberrypi:~ # exit
```

Create network interface file in /etc/systemd/network/eth0.network
```
[Match]
Name=eth0

[Network]
DHCP=yes

[Address]
Label=eth0:0
Address=10.132.25.1/29
```
Restart systemd networking
`sudo systemctl restart systemd-networkd`

### Morello Box
Add the following line to `/etc/rc.conf`

```
ifconfig_re0_alias0="10.132.25.2 netmask 255.255.255.248"
```

Restart the networking and routing daemons
`/etc/rc.d/netif restart && /etc/rc.d/routing restart`

### ssh-keys

#### Local

Ensure you have an ssh key to access the demonstrator box.

#### Raspberry Pi > Morello
Ensure the user you are running the demo from on the raspberry pi has a key
`ssh-keygen`

Copy this key to the morello box
`ssh-copy-id demo@10.132.25.2`

Test login
`ssh demo@10.132.25.2`
