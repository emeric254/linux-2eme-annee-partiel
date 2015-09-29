#!/bin/bash


#~ partitionement et formatage a faire avant
#~ dd if=/dev/zero of=$disk
#~ fdisk || parted || gparted || ...
#~ mkfs.ext4 $partition


if [ $# -ne 1 ]
then
    echo "Usage: ./$0 <UUID> "
    exit -1
fi

uuid=$1

echo "Creation du point de montage et montage"
mkdir /var/lib/iscsi-target
echo "UUID=\"$uuid\"         /var/lib/iscsi-target/  ext4    defaults        0       2" >> /etc/fstab
mount -a
echo "[OK]"

echo "Creation des images de volume"
cd /var/lib/iscsi-target/
dd if=/dev/zero of=initiator-1.disk bs=4k count=262144 # 1Go = 4ko * 262144
#~ dd if=/dev/zero of=initiator-2.disk bs=4k count=262144 # 1Go = 4ko * 262144
echo "[OK]"


echo "installation des paquets"
apt-get install open-iscsi targetcli


echo "redemarage du deamon"
#~ /etc/init.d/open-iscsi restart
service open-iscsi restart

echo "status du deamon"
service open-iscsi status

#~ echo "sessions ouvertes sur le deamon"
#~ iscsiadm -m session

#~ echo "liberation de toutes les sessions"
#~ iscsiadm -m node -U all



# lancer  targetcli
    #~  cd backstore
    #~  cd fileio    ou   cd iblock
    #~  create initiator1 /dev/sdb     ou  create initiator1 /var/lib/iscsi-target/initiator-1.disk
    #~
    #~  cd iscsi
    #~  create
    #~  cd iqn-machin/tpg1
    #~  luns/ create /backstore/filesio/initiator1
    #~  portals/ create $ipV4 3260
    #~  portals/ create $ipV6 3260


#~ aller test coter initiator et relever sa clef puis :
    #~  cd iscsi
    #~  create
    #~  cd iqn-machin/tpg1
    #~  acls/ create $iqn-de-l-initiator


#~ pour une authenfication open
    #~  set attribute authentication=0 demo_mode_write_protect=0

#~  authentification chap
    #~  acls/$iqn-de-l-initiator set auth userid=initiator-username
    #~  acls/$iqn-de-l-initiator set auth password=initiator-53cr3t-p455w0rd
#~ aller vois le fichier /etc/iscsi/iscsid.conf sur le client
    #~  > node.session.auth.authmethod = CHAP
    #~  > node.session.auth.username = SAN-lab-1stInitiator
    #~  > node.session.auth.password = MyS4N-1stInitiator-53cr3t


#~ on repart test sur le client et ca marche
