# Configuration du serveur Mattermost de CovidTracker

Configuration du serveur [Mattermost](https://mattermost.com) utilisé pour le développement de CovidTracker. 

Site accessible sur : [https://mattermost.covidtracker.fr](https://mattermost.covidtracker.fr)

## Infos sur le serveur

- VPS chez Scaleway
- Distribution : Ubuntu 20.04
- Serveur web : géré par Mattermost ([installation Omnibus](https://docs.mattermost.com/install/mattermost-omnibus.html))

Adresse IP publique : `51.15.204.41`

## Instructions

Cloner le projet sur le serveur :

`git clone https://github.com/CovidTrackerFr/mattermost-server.git config`

Lancer le script d’installation : 

`~/config/tools/install.sh`

Redémarrer le serveur à la fin du processus.