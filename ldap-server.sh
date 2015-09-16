#!/bin/bash


if [ $# -ne 3 ]
then
    echo "Usage: ./$0 <ou> <dc> <dc> "
    exit -1
fi

organisation=$1
dc1=$2
dc2=$3


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
#~  $dc.$dc
#~  $dc.$dc
#~  mdp a rentrer
#~  confirmation du mdp
#~  hdb
#~  oui (purge)
#~  oui (deplacement)
#~  non (ldapv2)
dpkg-reconfigure slapd


echo "creation et chargement des fichiers ldif pour la configuration supplementaire"
echo "  - logs"
mkdir temp-ldap
cat <<EOF >>./temp-ldap/setolcLogLevel2stats.ldif
# Set olcLogLevel 2 stats
dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: stats
EOF
ldapmodify -Y EXTERNAL -H ldapi:// -f ./temp-ldap/setolcLogLevel2stats.ldif
echo "  - structure"
cat <<EOF >>./temp-ldap/ou.ldif
dn: ou=$organisation,dc=$dc2,dc=$dc1
objectClass: organizationalUnit
ou: people

dn: ou=$organisation,dc=$dc2,dc=$dc1
objectClass: organizationalUnit
ou: groups
EOF
ldapadd -cxWD cn=admin,dc=$dc1 -f ./temp-ldap/ou.ldif

echo "[OK]"


echo "creation et chargement des fichiers ldif utilisateurs"
cat <<EOF >> ./temp-ldap/users.ldif

EOF
ldapadd -cxWD cn=$organisation,dc=$dc2,dc=$dc1 -f ./temp-ldap/users.ldif
echo "[OK]"


echo "mise en place du gestionnaire PHPLDAPADMIN"
aptitude install phpldapadmin apache2
sed -n '/<IfModule mpm_prefork_module>/,/<\/IfModule>/p' /etc/apache2/apache2.conf
a2enmod ssl
a2ensite default-ssl
/etc/init.d/apache2 restart
#~ manque config.php a modif pour phpldapadmin <---------------------------------------- @TODO
echo "[OK]"

