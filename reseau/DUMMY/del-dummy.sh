#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: ./$0 <nom>"
    exit -1
fi

nom=$1

# reset address et routes de l'interface
ip address flush dev $nom
ip route flush dev $nom

# desactivation de l'interface dummy
ip link set down dev $nom

# supression du dummy
ip link delete $nom type dummy

# decharge le module dummy
#rmmod dummy 2> /dev/null

