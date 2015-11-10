#!/bin/bash

# variables

numSortie=114
numPoste=115
rnisEncap="syncppp"

echo "vous etes sur le poste $numPoste"
echo "vous allez vous connecter au poste $numSortie"
echo "vous allez utiliser l'encapsulation $rnisEncap"


sleep 1


# chargement modules
echo "chargement des modules"
modprobe hisax
modprobe capi
modprobe i4l


# activation rnis
echo "ajout de l'interface rnis"
isdnctrl addif isdn0


echo "parametrage de l'interface rnis"

# parametrage rnis numero de sortie
echo "	- numero du correspondant : $numSortie"
isdnctrl addphone isdn0 in $numSortie
isdnctrl addphone isdn0 out $numSortie

# parametrage rnis numero du poste
echo "	- numero du poste : $numPoste"
isdnctrl eaz isdn0 $numPoste

# parametrage rnis
echo "	- dialmode : auto"
isdnctrl dialmode isdn0 auto
echo "	- l2_prot : hdlc"
isdnctrl l2_prot isdn0 hdlc
echo "	- encapsulation : $rnisEncap"
isdnctrl encap isdn0 $rnisEncap


# on sauvegarde le fichier de configuration rnis
echo "sauvegarde du fichier de configuration : rnis.conf"
isdnctrl writeconf rnis.conf


# on remplace "isdn0" par "ippp0" dans ce fichier
echo "remplacement de isdn0 par ippp0 dans ce fichier"
sed -i -e "s/isdn0/ippp0/g" rnis.conf


# on recharge la configuration rnis
echo "rechargement de ce fichier de configuration modifié"
isdnctrl readconf rnis.conf


# activation de l'interface
echo "activation de l'interface ippp0"
ip link set dev ippp0 up


# on lance le demon PPP
echo "lancement du deamon ipppd (noauth, debug)"
ipppd ippp0 noauth debug


sleep 3


# on tente un appel pour recuperer une adresse aupres du "serveur" (l'autre extremite du lien rnis)
echo "tentative d'appel sur le lien"
isdnctrl dial ippp0
