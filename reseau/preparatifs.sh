#!/bin/bash

killall dhclient

apt-get install quagga apache2 iptables iptstate

echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.default.rp_filter=1
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.conf.all.proxy_arp=0
sysctl -w net.ipv4.conf.all.log_martians=1

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 172.16.0.4" >> /etc/resolv.conf

