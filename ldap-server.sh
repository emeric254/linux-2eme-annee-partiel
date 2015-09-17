#!/bin/bash


if [ $# -ne 3 ]
then
    echo "Usage: ./$0 <ou> <dc> <dc> "
    exit -1
fi

organisation=$1
#~  ====>  dc2.dc1
dc1=$3
dc2=$2


echo "Installation"
apt-get install slapd ldap-utils
echo "[OK]"


echo "Arret du deamon"
service slapd stop


echo "purge de la configuration"
rm /var/lib/ldap/*
rm -rf /etc/ldap/slapd.d
echo "[OK]"


echo "creation de la configuration par dpkg-reconfigure"
#~ reponses pour l'utilitaire
#~  non (omettre)
#~  $dc2.$dc1
#~  $dc2.$dc1
#~  mdp a rentrer
#~  confirmation du mdp
#~  hdb
#~  oui (purge)
#~  oui (deplacement)
#~  non (ldapv2)
dpkg-reconfigure slapd


echo "Lancement du deamon"
service slapd start

echo "creation et chargement des fichiers ldif pour la configuration supplementaire"
mkdir temp-ldap

echo "  - logs"
cat <<EOF >./temp-ldap/setolcLogLevel2stats.ldif
# Set olcLogLevel 2 stats
dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: stats
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f ./temp-ldap/setolcLogLevel2stats.ldif

echo "  - structure"
cat <<EOF >./temp-ldap/ou.ldif
dn: ou=people,dc=$dc2,dc=$dc1
objectClass: organizationalUnit
ou: people

dn: ou=groups,dc=$dc2,dc=$dc1
objectClass: organizationalUnit
ou: groups
EOF

ldapadd -cxWD cn=admin,dc=$dc2,dc=$dc1 -f ./temp-ldap/ou.ldif
echo "[OK]"


echo "creation et chargement des fichiers ldif utilisateurs"
cat <<EOF > ./temp-ldap/users.ldif
# Padmé Amidala
dn: uid=padme,ou=$organisation,dc=$dc2,dc=$dc1
objectClass: person
objectClass: shadowAccount
objectClass: posixAccount
cn: Padme
sn: Padmé Amidala Skywalker
uid: padme
uidNumber: 10000
gidNumber: 10000
loginShell: /bin/bash
homeDirectory: /ahome/padme
userPassword: {SSHA}b1utGdYRN3JvGKiU5JrpKFLvNTrZODO8
gecos: Padme Amidala Skywalker

# Anakin Skywalker
dn: uid=anakin,ou=$organisation,dc=$dc2,dc=$dc1
objectClass: person
objectClass: shadowAccount
objectClass: posixAccount
cn: Anakin
sn: Anakin Skywalker
uid: anakin
uidNumber: 10001
gidNumber: 10001
loginShell: /bin/bash
homeDirectory: /ahome/anakin
userPassword: {SSHA}b1utGdYRN3JvGKiU5JrpKFLvNTrZODO8
gecos: Anakin Skywalker

# Leia Organa
dn: uid=leia,ou=$organisation,dc=$dc2,dc=$dc1
objectClass: person
objectClass: shadowAccount
objectClass: posixAccount
cn: Leia
sn: Leia Organa
uid: leia
uidNumber: 10002
gidNumber: 10002
loginShell: /bin/bash
homeDirectory: /ahome/leia
userPassword: {SSHA}b1utGdYRN3JvGKiU5JrpKFLvNTrZODO8
gecos: Leia Organa

# Luke Skywalker
dn: uid=luke,ou=$organisation,dc=$dc2,dc=$dc1
objectClass: person
objectClass: shadowAccount
objectClass: posixAccount
cn: Luke
sn: Luke Skywalker
uid: luke
uidNumber: 10003
gidNumber: 10003
loginShell: /bin/bash
homeDirectory: /ahome/luke
userPassword: {SSHA}b1utGdYRN3JvGKiU5JrpKFLvNTrZODO8
gecos: Luke Skywalker
EOF
ldapadd -cxWD cn=admin,dc=$dc2,dc=$dc1 -f ./temp-ldap/users.ldif
echo "[OK]"


echo "mise en place du gestionnaire PHPLDAPADMIN"
apt-get install phpldapadmin apache2
sed -n '/<IfModule mpm_prefork_module>/,/<\/IfModule>/p' /etc/apache2/apache2.conf
a2enmod ssl
a2ensite default-ssl
service apache2 restart
sed -i "s/dc=example,dc=com/dc=$dc2,dc=$dc1/g" /etc/phpldapadmin/config.php
service apache2 reload
echo "[OK]"

