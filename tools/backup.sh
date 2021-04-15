#!/bin/sh
DATE=`date +%Y-%m-%d_%H-%M-%S`
BACKUP="/root/backup"
DATA="/var/opt/mattermost/data/*"

echo "--- Sauvegarde $DATE ---"

echo "Nettoyages des anciennes sauvegardes"
find $BACKUP/ -maxdepth 1 -type f -mmin +7200 | xargs rm -rf

echo "Sauvegarde des bases de données"
sudo mmomni backup -d -o $BACKUP/$DATE.tgz

echo "--- Fin de la sauvegarde ---"