#!/bin/bash

GIT="/root/config"
HOME="/root"

# Nécessaire pour éviter les erreurs de LOCALE par la suite
locale-gen "en_US.UTF-8"
timedatectl set-timezone Europe/Paris

echo "======== Mise à jour initiale ========"
apt update
apt -y upgrade
apt -y dist-upgrade

echo "======== Installation de Mattermost ========"

curl -o- https://deb.packages.mattermost.com/repo-setup.sh | sudo bash
apt install mattermost-omnibus -y

echo "======== Installation des quelques outils ========"

apt-get -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

ln -s /root/config/home/.alias ~/.alias
ln -sf /root/config/home/.zshrc ~/.zshrc

echo "======== Configuration du pare-feu ========"
ufw allow ssh
ufw allow http
ufw allow https
ufw allow 3306/tcp
ufw enable

echo "======== Configuration de la sauvegarde ========"

## Fichiers de log

### Création des fichiers et permissions
mkdir $HOME/backup/
mkdir -p /var/log/
touch /var/log/backup.log

### Logrotate pour les log de backup
tee -a /etc/logrotate.d/backup <<EOF
/var/log/backup.log {
    rotate 6
    daily
    missingok
    dateext
    copytruncate
    notifempty
    compress
}
EOF

## Création du cron
tee -a /etc/cron.d/backup <<EOF
# Sauvegarde tous les jours à 215
15 2 * * * root /etc/macg/tools/backup.sh >> /var/log/backup.log 2>&1
EOF

# Fin du script
apt -y autoremove

echo "Le script est terminé, la machine doit être redémarrée pour que l'installation soit complète."
