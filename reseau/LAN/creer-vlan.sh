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
ip link add link $interface name $interface.$numVlan type vlan id $numVlan

# ajout adresse
ip address add $ipMask dev $interface.$numVlan

# activation interface
ip link set up $interface

# activation vlan
ip link set up $interface.$numVlan

