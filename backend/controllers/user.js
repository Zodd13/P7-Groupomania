const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const models = require("../models");


exports.signup = (req, res, next) => {
  let email = req.body.email;
  let username = req.body.username;
  let password = req.body.password;
  let bio = req.body.bio;
  const EMAIL_REGEX = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  const PASSWORD_REGEX = /^(?=.*\d).{4,20}$/

  if (email == null || username == null || password == null) {
    return res.status(400).json({ error: "Données manquantes." });
  }

  if(!EMAIL_REGEX.test(email)){
    return res.status(400).json({'error' : "L'adresse email est invalide."});
  }
  if(!PASSWORD_REGEX.test(password)){
    return res.status(400).json({'error' : "Mot de passe invalide il doit être en 4 et 20 caractères et contenir un chiffre."});
  }

  models.User.findOne({
    attributes: ["email"],
    where: { email: email },
  })
    .then(function (userFound) {
      if (!userFound) {
        bcrypt.hash(password, 10, function (err, bcryptedPassword) {
          let newUser = models.User.create({
            email: email,
            username: username,
            password: bcryptedPassword,
            bio: bio,
            isAdmin: 0,
          })
            .then(function (newUser) {
              return res.status(201).json({
                userId: newUser.id,
              });
            })
            .catch(function () {
              return res.status(400).json({ error: err });
            });
        });
      } else {
        return res.status(409).json({ error: "L'utilisateur existe déjà." });
      }
    })
    .catch(function (err) {
      return res.status(500).json({ error: err });
    });
};

exports.login = (req, res, next) => {
  let email = req.body.email;
  let password = req.body.password;

  models.User.findOne({
    where: { email: email },
  })
    .then((userFound) => {
      if (!userFound) {
        return res.status(401).json({ error: "Utilisateur non trouvé." });
      }
      bcrypt
        .compare(password, userFound.password)
        .then((valid) => {
          if (!valid) {
            return res.status(401).json({ error: "Mot de passe incorrect." });
          }
          res.status(200).json({
            userId: userFound.id,
            isAdmin: userFound.isAdmin,
            token: jwt.sign({ userId: userFound.id }, `${process.env.SECRET_KEY}`, {
              expiresIn: "24h",
            }),
          });
        })
        .catch((error) => res.status(500).json({ error }));
    })
    .catch((error) => res.status(500).json({ error: console.log(error) }));
};

exports.profile = (req, res, next) => {
  const token = req.headers.authorization;
  const decodedToken = jwt.verify(token, `${process.env.SECRET_KEY}`);
  const userId = decodedToken.userId;

  models.User.findOne({
    attributes: ["id", "email", "username", "bio", "isAdmin"],
    where: { id: userId },
  })
    .then(function (user) {
      if (user) {
        res.status(201).json(user);
      } else {
        res.status(404).json({ error: "Utilisateur non trouvé." });
      }
    })
    .catch(function (err) {
      res.status(500).json({ error: console.log(err) });
    });
};

exports.updateUser = (req, res, next) => {
  const token = req.headers.authorization;
  const decodedToken = jwt.verify(token, `${process.env.SECRET_KEY}`);
  const userId = decodedToken.userId;

  let username = req.body.username;
  let email = req.body.email;
  let bio = req.body.email;

  const EMAIL_REGEX = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  const PASSWORD_REGEX = /^(?=.*\d).{4,20}$/

  if (email == null || username == null || password == null) {
    return res.status(400).json({ error: "Données manquantes." });
  }

  if(!EMAIL_REGEX.test(email)){
    return res.status(400).json({'error' : "L'adresse email est invalide."});
  }
  if(!PASSWORD_REGEX.test(password)){
    return res.status(400).json({'error' : "Mot de passe invalide il doit être en 4 et 20 caractères et contenir un chiffre."});
  }
  
  models.User.findOne({
    where: { id: userId },
  })
    .then(function (userFound) {
      userFound
        .update({
          bio: bio,
          username: username,
          email: email,
        })
        .then(res.status(201).json({ message: "Profil mis à jour." }));
    })
    .catch((err) => err.json(err));
};

exports.deleteUser = (req, res, next) => {
  const token = req.headers.authorization;
  const decodedToken = jwt.verify(token, `${process.env.SECRET_KEY}`);
  const userId = decodedToken.userId;

  models.Publication.findAll({
    attributes: ["id"],
    where: { UserId: userId },
  });
  models.Commentaire.findAll({
    attributes: ["id"],
    where: { UserId: userId },
  }).then(function (Publication, Commentaire) {
    models.Publication.destroy({
      where: { UserId: userId },
    });
    models.Commentaire.destroy({
      where: { UserId: userId },
    }).then(function (Commentaire) {
      models.User.findOne({
        attribute: ["id"],
        where: { id: userId },
      })
        .then(function (userFound) {
          userFound
            .destroy({
              where: { id: userFound },
            })
            .then(res.status(200).json({ message: "Utilisateur supprimer." }));
        })
        .catch(function (error) {
          res.status(500).json({ error: error });
        });
    });
  });
};
