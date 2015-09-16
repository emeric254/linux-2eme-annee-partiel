#!/bin/bash

if [ $# -ne 4 ]
then
    echo "Usage: ./$0 <ip server> <ou> <dc> <dc> "
    exit -1
fi

ip=$1
organisation=$2
dc1=$3
dc2=$4

aptitude install ldap-utils
aptitude install libnss-ldap

#~ ldapsearch -LLL -H ldap://$ip \ -b dc=$dc1 -D cn=admin,dc=$dc1 -W uid=robin
#~ --Changer le mdp de robin
#~ ldappasswd -x -H ldap://$ip -D cn=admin,dc=$dc1 -W -S uid=robin,ou=people,dc=$dc1

