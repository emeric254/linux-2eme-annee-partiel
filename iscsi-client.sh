#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: ./$0 <ip> <port> "
    exit -1
fi

ip=$1
port=$2


echo "installation des paquets"
apt-get install open-iscsi targetcli


echo "redemarage du deamon"
#~ /etc/init.d/open-iscsi restart
service open-iscsi restart

echo "status du deamon"
service open-iscsi status

echo "decouverte du serveur"
iscsiadm -m discovery --type sendtargets --portal=$ip:$port

#~ echo "sessions ouvertes sur le deamon"
#~ iscsiadm -m session

#~ echo "liberation de toutes les sessions"
#~ iscsiadm -m node -U all

echo "relever la clef iqn a fournir a la target"
grep -v ^# /etc/iscsi/initiator.name
