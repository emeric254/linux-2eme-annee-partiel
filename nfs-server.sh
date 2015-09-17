#!/bin/bash


if [ $# -ne 2 ]
then
    echo "Usage: ./$0 <ip> <masque> "
    exit -1
fi

ip=$1
masque=$2

#~ installation des paquets
apt-get install rpcbind nfs-common nfs-kernel-server

#~ config nfs-common
sed -i "s/NEED_STATD=/NEED_STATD=no/g" /etc/default/nfs-common
sed -i "s/NEED_IDMAPD=/NEED_IDMAPD=YES/g" /etc/default/nfs-common

#~ on arrete le deamon
#~ /etc/init.d/nfs-common stop
service nfs-common stop
killall rpc_statd

#~ on demare le daemon
#~ /etc/init.d/nfs-common start
service nfs-common start

#~ .
#~ scp du fichier exports
#~ .

#~ /etc/init.d/nfs-kernel-server restart
service nfs-kernel-server restart

#~ creation du dossier ahome partagé
mkdir /ahome
mount --bind /home/exports/home /ahome

#~ creation fichier exports
cat <<EOF >> /etc/exports
/home/exports           $ip/$masque(rw,sync,fsid=0,crossmnt,no_subtree_check)
/home/exports/home      $ip/$masque(rw,sync,no_subtree_check)
EOF

#~ ajout utilisateur local avec home dans le dossier de partage
adduser --home /ahome/etu-nfs etu-nfs
