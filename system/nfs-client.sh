#!/bin/bash


if [ $# -ne 1 ]
then
    echo "Usage: ./$0 <ip> "
    exit -1
fi

ip=$1

#~ installation des paquets
apt-get install rpcbind nfs-common

#~ config nfs-common
sed -i "/NEED_STATD=/c\NEED_STATD=no/g" /etc/default/nfs-common
sed -i "/NEED_IDMAPD=/c\NEED_IDMAPD=YES/g" /etc/default/nfs-common

#~ on arrete le deamon
#~ /etc/init.d/nfs-common stop
service nfs-common stop
killall rpc_statd

#~ on demare le deamon
#~ /etc/init.d/nfs-common start
service nfs-common start

#~ quelques tests
#~ rpcinfo -s $ip
#~ showmount -e $ip
#~ dpkg -S `which mount`

#~ creation du repertoire qui fera dossier partagé
mkdir /ahome
mount -t nfsv4 $ip:/home /ahome

#~ rendre le montage MANUELLEMENT permanent:
echo "$ip:/home \t /ahome \t nfs4 \t 0 \t 0" >> /etc/ftab



#~ ---------------------------------------------------------------------


#~ installation de auto-fs
apt-get install autofs

#~ creation d'un utilisateur avec home dans le dossier partagé
adduser --no-create-home --home /ahome/etu-nfs etu-nfs

#~ ajouter /ahome \t /etc/auto.home à /etc/auto.master
cat <<EOF > /etc/auto.master
/ahome  /etc/auto.home
EOF

cat <<EOF > /etc/auto.home
*       -fstype=nfs4    $ip:/home/&
EOF

echo "penser a demonter manuellement ce qui est fait pour que le montage automatique puisse reussir !!!"
