Cloner  le dépôt  sur votre ordinateur.

Lancer le dossier Groupomania sur  votre éditeur de texte.

Via le terminal rendez vous sur le dossier backend : CD backend.

Lancez npm install

Renvez vous ensuite  sur le dossier Frontend : cd .. et CD frontend.

Installer les dépendences nécéssaires au projet avec : 

npm install

puis 

yarn install

Lancez ensuite le projet avec Yarn run serve

////

Une fois la projet installé, il va falloir configurer le fichier .env,
rendez vous donc dans le dossier backend et créer un fichier à la racine de ce dernier appeler .env.
Dans ce fichier créer une variable appeler SECRET_KEY="Mettez un mot de passe ici"

////

Dans le dossier config du backend remplacer les données du fichiers config.json par les données de votre base de données.

Connectez vous à votre base de données.

Créer une base de données appelé Groupomania : CREATE DATABASE groupomania;

Via l'invite de commande rendez vous dans le dossiers \P7-Groupomania où se situe le DUMP de la base de données.

Via le terminal lancez : mysql -u root -p groupomania < dump.sql

Une fois ceci fait vous aurez accès au projet. Un compte administrateur est déjà créer :

EMAIL = Admin@admin.com
MOT DE PASSE = Admin1
