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
echo "UUID=$uuid         /var/lib/iscsi-target/  ext4    defaults        0       2" >> /etc/fstab
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

#~ iscsiadm -m discovery --type sendtargets --portal=$ip:$port


# lancer le menu iscsi machin
#~ --cible iscsi
#~ cd /iscsi
#~ create
#~ cd iqn ....
#~ cd tpg1
#~ luns/ create /backstore/filesio/initiator1
#~ portals/ create 10.0.2.10 3260
#~
#~ //prendre la cle du client
#~ tpg1 etc ...
#~ cd acls
#~ create iqn"clé client"
