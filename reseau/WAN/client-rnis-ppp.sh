#!/bin/bash

# interface
interface="ippp0"

# numeros du poste et de sortie
numSortie=114
numPoste=115

# encapsulation (syncppp ou rawip)
rnisEncap="syncppp"

################################################################################

echo "vous etes sur le poste $numPoste"
echo "vous allez vous connecter au poste $numSortie"
echo "vous allez utiliser l'encapsulation $rnisEncap"

sleep 1

################################################################################

# chargement modules
echo "chargement des modules"
modprobe hisax  2> /dev/null
modprobe capi   2> /dev/null
modprobe i4l    2> /dev/null


# activation rnis
echo "ajout de l'interface rnis"
isdnctrl addif $interface

# virer l'interface rnis
#isdnctrl delif $interface

################################################################################

echo "parametrage de l'interface rnis"

# parametrage rnis numero de sortie
echo "  - numero du correspondant : $numSortie"
isdnctrl addphone $interface in $numSortie
isdnctrl addphone $interface out $numSortie

# virer le numero de sortie
#isdnctrl delphone $interface in $numSortie
#isdnctrl delphone $interface out $numSortie


# parametrage rnis numero du poste
echo "  - numero du poste : $numPoste"
isdnctrl eaz $interface $numPoste


# parametrage rnis
echo "  - dialmode : auto"
isdnctrl dialmode $interface auto
echo "  - l2_prot : hdlc"
isdnctrl l2_prot $interface hdlc
echo "  - encapsulation : $rnisEncap"
isdnctrl encap $interface $rnisEncap

################################################################################

# on sauvegarde le fichier de configuration rnis
echo "sauvegarde du fichier de configuration : rnis.conf"
isdnctrl writeconf rnis.conf

################################################################################

# on recharge la configuration rnis
#~ echo "rechargement de ce fichier de configuration"
#~ isdnctrl readconf rnis.conf

################################################################################

# activation de l'interface
echo "activation de l'interface"
ip link set dev $interface up


# on lance le demon PPP
echo "lancement du deamon ipppd (noauth, debug)"
ipppd $interface noauth debug

sleep 3

################################################################################

# on tente un appel pour recuperer une adresse aupres du "serveur" (l'autre extremite du lien rnis)
echo "tentative d'appel sur le lien"
isdnctrl dial $interface

# raccrocher
#isdnctrl hangup $interface

