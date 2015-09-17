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

echo "installation des paquets"
apt-get install ldap-utils libnss-ldap libpam-ldap nscd


echo "test du serveur avec recup des infos de 'padme'"
ldapsearch -LLL -H ldap://$ip -b dc=$dc2,dc=$dc1 -D cn=admin,dc=$dc2,dc=$dc1 -W uid=padme
echo "[OK]"


#~ Pour le paquet libpam-ldap, voici la liste des options retenues.
    #~ Identifiant uniforme de ressource (« URI ») d'accès au serveur LDAP : ldap://$ip
    #~ Nom distinctif (DN) de la base de recherche : dc=$dc2,dc=$dc1
    #~ Version de LDAP à utiliser : 3
    #~ Donner les privilèges de superutilisateur local au compte administrateur LDAP ? oui
    #~ La base de données LDAP demande-t-elle une identification ? non
    #~ Compte de l'administrateur LDAP : cn=admin,dc=$dc2,dc=$dc1
    #~ Mot de passe du compte de l'administrateur LDAP : *****
    #~ Algorithme de chiffrement à utiliser localement pour les mots de passe : Chiffré
    #~ Profils PAM à activer : Unix authentication + LDAP Authentication
echo "Menu de configuration du paquet libnss-ldap"
dpkg-reconfigure libnss-ldap
echo "Menu de configuration du paquet libpam-ldap"
dpkg-reconfigure libpam-ldap

echo "configuration de /etc/nsswitch.conf"
sed -i '/passwd:/c\passwd:         compat ldap' /etc/nsswitch.conf
sed -i '/group:/c\group:         compat ldap' /etc/nsswitch.conf
sed -i '/shadow:/c\shadow:         compat ldap' /etc/nsswitch.conf
echo "[OK]"

echo "redemarage de nscd"
#~ /etc/init.d/nscd restart
service nscd restart


#~ ldapsearch -LLL -H ldap://$ip \ -b dc=$dc1 -D cn=admin,dc=$dc1 -W uid=robin
#~ --Changer le mdp de robin
#~ ldappasswd -x -H ldap://$ip -D cn=admin,dc=$dc1 -W -S uid=robin,ou=people,dc=$dc1

