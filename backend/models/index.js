//connexion sequelize à la base de données
'use strict';
const fs = require("fs");
const path = require("path");
const Sequelize = require("sequelize");
const basename = path.basename(__filename);
const db = {};

let sequelize;

sequelize = new Sequelize("groupomania", "mounir", "Kakossekos95", {
  host: "localhost",
  dialect: "mysql"
});

//connexion à la database
sequelize.authenticate()
  .then(() => console.log('La connexion est établie.'))
  .catch((err) => console.log('La connexion a échoué', err));

fs
  .readdirSync(__dirname)
  .filter(file => {
    return (file.indexOf('.') !== 0) && (file !== basename) && (file.slice(-3) === '.js');
  })
  .forEach(file => {
    const model = require(path.join(__dirname, file))(sequelize, Sequelize.DataTypes);
    db[model.name] = model;
  });

Object.keys(db).forEach(modelName => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
