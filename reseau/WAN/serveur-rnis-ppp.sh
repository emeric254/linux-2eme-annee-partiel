#!/bin/bash

# interface
interface="ippp0"

# numeros du poste et du correpondant (l'autre)
numAutre=115
numPoste=114

# encapsulation (syncppp ou rawip)
rnisEncap="syncppp"

# IP du poste et IP du correpondant (l'autre)
ipPoste="192.168.114.1"
ipAutre="192.168.114.2"

################################################################################

echo "vous etes sur le poste $numPoste"
echo "vous allez attendre la connexion du poste $numSortie"
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
echo "  - numero du correspondant : $numAutre"
isdnctrl addphone $interface in $numAutre
isdnctrl addphone $interface out $numAutre

# virer le numero de sortie
#isdnctrl delphone $interface in $numAutre
#isdnctrl delphone $interface out $numAutre


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


# bind ppp on this interface (config de HUB !)
#isdnctrl pppbind $interface

################################################################################

# on sauvegarde le fichier de configuration rnis
echo "sauvegarde du fichier de configuration : rnis.conf"
isdnctrl writeconf rnis.conf

################################################################################

# on recharge la configuration rnis
#~ echo "rechargement de ce fichier de configuration"
#~ isdnctrl readconf rnis.conf

################################################################################

# desactivation de l'auto reset des routes pour l'interface
sed -i -e "s/route del default/# route del default/g" /etc/ppp/ip-down /etc/ppp/ip-up /etc/ppp/ip-down.d /etc/ppp/ip-up.d  2> /dev/null

################################################################################

# activation ip foward
echo "activation ip_forward ipv4"
echo 1 > /proc/sys/net/ipv4/ip_forward

################################################################################

# activation de l'interface
echo "activation de l'interface"
ip link set dev $interface up

# parametrage de l'IP de l'interface
echo "paramtrage de l'IP de l'interface"
ip address add $ipPoste/30 dev $interface

# on lance le demon PPP
echo "lancement du deamon ipppd (noauth, debug)"
ipppd $interface noauth debug $ipPoste:$ipAutre

# pour chap :
# aller voir dans le fichier /etc/ppp/chap-secrets pour ajouter la ligne qui va bien (login * pass)
#ipppd ippp0 noauth name LOGIN debug +pwlog

