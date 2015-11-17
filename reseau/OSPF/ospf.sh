#!/bin/bash

modprobe 8021q 	2> /dev/null

# se deplacer dans le bon dossier
cd /etc/quagga

# activation deamons
sed -i -e "s/ospfd=no/ospfd=yes/g" /etc/quagga/daemons  2> /dev/null
sed -i -e "s/zebra=no/zebra=yes/g" /etc/quagga/daemons  2> /dev/null

# preparation fichiers de conf examples
cp /usr/share/doc/quagga/examples/zebra.conf.sample zebra.conf.example
cp /usr/share/doc/quagga/examples/ospfd.conf.sample ospfd.conf.example

# configuration zebra
cat <<EOF > zebra.conf
! -*- zebra -*-
!
hostname R1-zebra
password zebra
enable password zebra
!
log file /var/log/quagga/zebra.log
!
!
!interface eth0
! bandwidth 100000
! ipv6 nd suppress-ra
!
!interface eth0.12
! bandwidth 100000
! ipv6 nd suppress-ra
!
!interface eth0.13
! bandwidth 100000
! ipv6 nd suppress-ra
EOF

# configuration a la main restante pour zebra
echo "finir la configuration de 'zebra.conf'"
echo "voir les interfaces a regler"
sleep 3
vim zebra.conf

# configuration ospfd
cat <<EOF > ospfd.conf
! -*- ospf -*-
!
hostname R1-ospfd
password zebra
enable password zebra
!
log file /var/log/quagga/ospfd.log
EOF

# modif de leur proprietaire
chown quagga zebra.conf ospfd.conf

# redemarage du deamon quagga
systemctl restart quagga

# connexion cli zebra
#echo " >> cli zebra :"
#echo "password = zebra"
#telnet localhost zebra

# connexion cli ospfd
echo " >> cli ospfd :"
echo "password = zebra"
echo "il faut maintenant parametrer les routes que l'on va annoncer"
echo "# conf"
echo "(config)# router ospf"
echo "(config-router)# router-id 0.0.0.X"
echo "(config-router)# network X.X.X.X/Y area 0"
echo "(config-router)# network X.X.X.X/Y area 0"
echo "# sh ip ospf neighbor"
echo "# sh ip ospf route"
sleep 5
telnet localhost ospfd

