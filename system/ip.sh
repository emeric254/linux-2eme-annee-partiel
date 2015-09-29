#!/bin/bash

#~ Correspondance poste / ip
#
#~      SCSI
#~ Poste 1      Poste 2         Passerelle par défaut
#~ alderaan     bespin          10.4.4.1/23
#~ centares     coruscant       192.168.109.1/25
#~ dagobah      endor           10.0.117.1/27
#~ felucia      geonosis        10.7.10.1/23
#~ hoth         mustafar        172.19.112.1/26
#~ naboo        tatooine        192.168.111.1/25
#
#~      NFS
#~ Poste 1      Poste 2         Passerelle par défaut
#~ alderaan     bespin          172.19.116.1/26
#~ centares     coruscant       10.0.119.65/27
#~ dagobah      endor           10.0.121.129/27
#~ felucia      geonosis        172.19.114.129/26
#~ hoth         mustafar        192.168.108.129/25
#~ naboo        tatooine        10.5.6.1/23
#
#~      LDAP
#~ Affectation des adresses IP des postes de travaux pratiques
#~ Poste 1      Poste 2         Passerelle par défaut   Organisation
#~ alderaan     bespin          172.24.132.17/28        o: zone1.lan-213.stri
#~ centares     coruscant       172.20.129.17/29        o: zone2.lan-213.stri
#~ dagobah      endor           192.168.123.17/28       o: zone3.lan-213.stri
#~ felucia      geonosis        192.168.125.49/28       o: zone4.lan-213.stri
#~ hoth         mustafar        10.5.6.1/23             o: zone5.lan-213.stri
#~ naboo        tatooine        172.20.136.81/28        o: zone6.lan-213.stri


#~ Correspondance ip / vlan
#
#~ swd1.infra.stri
    #~ 100      172.17.0.1/22           2a01:240:feb2:64::1/64
#
#~ sw2-213.infra.stri
    #~ 101      172.18.4.1/22           2a01:240:feb2:65::1/64
    #~ 102      10.3.2.1/23             2a01:240:feb2:66::1/64
    #~ 103      10.4.4.1/23             2a01:240:feb2:67::1/64
    #~ 104      10.5.6.1/23
    #~ 105      10.6.8.1/23
#
#~ sw3-213.infra.stri
    #~ 106     10.7.10.1/23             2a01:240:feb2:6a::1/64
    #~ 107     192.168.107.1/25         2a01:240:feb2:6b::1/64
    #~ 108     192.168.108.129/25       2a01:240:feb2:6c::1/64
    #~ 109     192.168.109.1/25
    #~ 110     192.168.110.129/25
#
#~ sw4-213.infra.stri
    #~ 111     192.168.111.1/25         2a01:240:feb2:6f::1/64
    #~ 112     172.19.112.1/26          2a01:240:feb2:70::1/64
    #~ 113     172.19.113.65/26         2a01:240:feb2:71::1/64
    #~ 114     172.19.114.129/26
    #~ 115     172.19.115.193/26
#
#~ sw5-213.infra.stri
    #~ 116     172.19.116.1/26          2a01:240:feb2:74::1/64
    #~ 117     10.0.117.1/27            2a01:240:feb2:75::1/64
    #~ 118     10.0.118.33/27           2a01:240:feb2:76::1/64
    #~ 119     10.0.119.65/27
    #~ 120     10.0.120.97/27
#
#~ sw6-213.infra.stri
    #~ 121     10.0.121.129/27          2a01:240:feb2:79::1/64
    #~ 122     192.168.122.1/28         2a01:240:feb2:7a::1/64
    #~ 123     192.168.123.17/28        2a01:240:feb2:7b::1/64
    #~ 124     192.168.124.33/28
    #~ 125     192.168.125.49/28
#
#~ sw7-213.infra.stri
    #~ 126     192.168.126.65/28        2a01:240:feb2:7e::1/64
    #~ 127     172.20.127.1/29          2a01:240:feb2:7f::1/64
    #~ 128     172.20.128.9/29          2a01:240:feb2:80::1/64
    #~ 129     172.20.129.17/29
    #~ 130     172.20.130.25/29
#
#~ sw8-213.infra.stri
    #~ 131     172.20.131.33/29         2a01:240:feb2:83::1/64
    #~ 132     172.24.132.17/28         2a01:240:feb2:84::1/64
    #~ 133     172.24.133.33/28         2a01:240:feb2:85::1/64
    #~ 134     172.20.134.49/28
    #~ 135     172.20.135.65/28
#
#~ sw9-213.infra.stri
    #~ 136     172.20.136.81/28         2a01:240:feb2:88::1/64
    #~ 137     10.137.0.1/27            2a01:240:feb2:89::1/64
    #~ 138     10.138.0.33/27           2a01:240:feb2:8a::1/64
    #~ 139     10.139.0.65/27
    #~ 140     10.140.0.97/27
#
#~ sw10-213.infra.stri
    #~ 141     10.141.0.129/27          2a01:240:feb2:8d::1/64
    #~ 142     192.168.142.1/26         2a01:240:feb2:8e::1/64
    #~ 143     192.168.143.65/26        2a01:240:feb2:8f::1/64
    #~ 144     192.168.144.129/26
    #~ 145     192.168.145.193/26
#
#~ sw11-213.infra.stri
    #~ 146     pas de routage
    #~ 147     pas de routage
    #~ 148     pas de routage
    #~ 149     pas de routage
    #~ 150     pas de routage


#~ Correspondance vlan / ports
#
#~ sw2-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 101  lan-101.stri    Fa0/1 - 4       access
#~ 102  lan-102.stri    Fa0/5 - 8       access
#~ 103  lan-103.stri    Fa0/9 - 12      access
#~ 104  lan-104.stri    Fa0/13 - 16     access
#~ 105  lan-105.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw3-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 106  lan-106.stri    Fa0/1 - 4       access
#~ 107  lan-107.stri    Fa0/5 - 8       access
#~ 108  lan-108.stri    Fa0/9 - 12      access
#~ 109  lan-109.stri    Fa0/13 - 16     access
#~ 110  lan-110.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw4-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 111  lan-111.stri    Fa0/1 - 4       access
#~ 112  lan-112.stri    Fa0/5 - 8       access
#~ 113  lan-113.stri    Fa0/9 - 12      access
#~ 114  lan-114.stri    Fa0/13 - 16     access
#~ 115  lan-115.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw5-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 116  lan-116.stri    Fa0/1 - 4       access
#~ 117  lan-117.stri    Fa0/5 - 8       access
#~ 118  lan-118.stri    Fa0/9 - 12      access
#~ 119  lan-119.stri    Fa0/13 - 16     access
#~ 120  lan-120.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw6-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 121  lan-121.stri    Fa0/1 - 4       access
#~ 122  lan-122.stri    Fa0/5 - 8       access
#~ 123  lan-123.stri    Fa0/9 - 12      access
#~ 124  lan-124.stri    Fa0/13 - 16     access
#~ 125  lan-125.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw7-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 126  lan-126.stri    Fa0/1 - 4       access
#~ 127  lan-127.stri    Fa0/5 - 8       access
#~ 128  lan-128.stri    Fa0/9 - 12      access
#~ 129  lan-129.stri    Fa0/13 - 16     access
#~ 130  lan-130.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw8-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 131  lan-131.stri    Fa0/1 - 4       access
#~ 132  lan-132.stri    Fa0/5 - 8       access
#~ 133  lan-133.stri    Fa0/9 - 12      access
#~ 134  lan-134.stri    Fa0/13 - 16     access
#~ 135  lan-135.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw9-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 136  lan-136.stri    Fa0/1 - 4       access
#~ 137  lan-137.stri    Fa0/5 - 8       access
#~ 138  lan-138.stri    Fa0/9 - 12      access
#~ 139  lan-139.stri    Fa0/13 - 16     access
#~ 140  lan-140.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw10-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 141  lan-141.stri    Fa0/1 - 4       access
#~ 142  lan-142.stri    Fa0/5 - 8       access
#~ 143  lan-143.stri    Fa0/9 - 12      access
#~ 144  lan-144.stri    Fa0/13 - 16     access
#~ 145  lan-145.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri
#
#~ sw11-213.infra.stri
#~ VLAN         Nom     Port(s)         Mode
#~ 146  lan-146.stri    Fa0/1 - 4       access
#~ 147  lan-147.stri    Fa0/5 - 8       access
#~ 148  lan-148.stri    Fa0/9 - 12      access
#~ 149  lan-149.stri    Fa0/13 - 16     access
#~ 150  lan-150.stri    Fa0/17 - 20     access
#~ 1    infra.stri      Fa0/21 - 24     trunk en réserve
#~ 1    infra.stri      Gi0/1 - 2       trunk connecté à swd1.infra.stri



if [ $# -ne 3 ]
then
    echo "Usage: ./$0 <ip machine> <masque> <ip passerelle>"
    exit -1
fi

ipposte=$1
masque=$2
ippasserelle=$3

echo "desactivation nde l'interface reseau"
#~ killall dhcp
ip l s dev eth0 down

echo "purge de la configuration actuelle "
ip r f dev eth0
ip a f dev eth0
echo "[OK]"

echo "Mise en place de l'adresse ip $ipposte / $masque  avec comme passerelle $ippasserelle "
ip a a $ipposte/$masque dev eth0
ip r a default via $passerelle dev eth0
echo "[OK]"

echo "Mise en place du serveur de nom $ippasserelle "
echo nameserver $ippasserelle > /etc/resolv.conf
echo "$ipposte  vm-ldap-server" >> /etc/hosts
echo "[OK]"


echo "Activation de l'interface reseau "
ip l s dev eth0 up

echo "Status "
ip l sh dev eth0
ip a s dev eth0
ip r s dev eth0
