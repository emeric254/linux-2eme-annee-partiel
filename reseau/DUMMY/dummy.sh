#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: ./$0 <ip> <masque ( le nbr de X.X.X.X/Y )>"
    exit -1
fi

ip=$1
mask=$2

# chargement du module
modprobe dummy 2> /dev/null

# plusieurs dummies, X = nbr de dummy :
#modprobe dummy numdummies=X  2> /dev/null

# renommage du dummy
#ip link set name $nom dev dummy0

# activation de l'interface dummy
ip link set up dev dummy0

# parametrage de l'interface
ip addr add $ip/$mask brd + dev dummy0

# config bind dans les fichier de conf apache
sed -i -e "s/Listen 80/Listen $ip:80/g" /etc/apache2/ports.conf  2> /dev/null
sed -i -e "s/Listen 443/Listen $ip:443/g" /etc/apache2/ports.conf  2> /dev/null

# redemarage apache
systemctl restart apache2

