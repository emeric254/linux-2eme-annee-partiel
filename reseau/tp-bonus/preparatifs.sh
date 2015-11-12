#!/bin/bash

nodeName=`uname -n`

# installation des paquets
echo "installation des paquets"
apt-get update
apt-get install ipppd apache2 quagga


# affichage details pour le poste
echo "-------------------------------------------------------------------------"
echo "details réseau pour ce poste : $nodeName"
echo "	- RNIS : "
grep $nodeName table-addr-RNIS
echo "	- VLAN : "
grep $nodeName table-addr-VLAN


# activation ip foward
echo "activation ip_forward ipv4"
echo 1 > /proc/sys/net/ipv4/ip_forward

# iptables -t nat -A POSTROUTING -o $interfaceSortie -j MASQUERADE


# virer le dhclient qui reset la conf toutes les 5 mins
echo "killall dhclient"
killall dhclient

