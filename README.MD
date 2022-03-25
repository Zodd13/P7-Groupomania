Avant de lancer le projet, quelques étapes sont nécessaires.

##

- Cloner  le dépôt  sur votre ordinateur.

- Ouvrez le projet avec votre éditeur de code.

- Via le terminal naviguez vers le dossier backend et lancer la commande ```npm install```

- Naviguez vers le dossier frontend et lancer la commande ```npm install```

- Vous pouvez lancer le projet via la commande ```npm run serve```

##

Une fois le projet installé, il va falloir configurer le fichier ```.env```

Rendez vous donc dans le dossier backend et créer un fichier à la racine de ce dernier appeler  ```.env```

Dans ce fichier créer une variable appelée  ```SECRET_KEY="Mettez un mot de passe ici"```

Faites de même avec vos identifiants de connexion à votre base de données : 

```DB_NAME="Le nom de votre base de donnée mysql"```

```DB_PASSWORD="Le mot de passe de votre base de données"```

##

Un dump de la base de données est présent à la racine du projet.

##

Créer une base de données appelé Groupomania : ```CREATE DATABASE groupomania;```

Via l'invite de commande rendez vous dans le dossier du projet où se situe le DUMP de la base de données.

Via le terminal lancez : ```mysql -u root -p groupomania < dump.sql```

Une fois ceci fait vous aurez accès au projet. Un compte administrateur est déjà créer :

```EMAIL = Admin@admin.com```

```MOT DE PASSE = Admin1```
