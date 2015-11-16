#!/bin/bash

apt-get install quagga apache2 iptables iptstate

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.default.rp_filter=1
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.conf.all.proxy_arp=0
sysctl -w net.ipv4.conf.all.log_martians=1

nameserver 8.8.8.8 > /etc/resolv.conf
nameserver 172.16.0.4 >> /etc/resolv.conf

