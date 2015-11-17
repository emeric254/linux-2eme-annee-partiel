#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: ./$0 <interface> <numVlan>"
    exit -1
fi

interface=$1
numVlan=$2

# desactivation du vlan
ip link set down dev $interface.$numVlan

# supression route(s) du vlan
ip route flush dev $interface.$numVlan

# suppression adresse(s) du vlan
ip address flush dev $interface.$numVlan

# supression du vlan
ip link del link dev $interface.$numVlan

