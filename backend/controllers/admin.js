const jwt = require("jsonwebtoken");
const models = require("../models");

exports.getPublications = (req, res, next) => {
    models.Publication.findAll({
      include: models.User,
      attributes: ["UserId","message", "image", "id", "createdAt", "status"],
      where: {status: 0},
    })
      .then(function (publication) {
        if (publication) {
          res.status(200).json({ publication });
        } else {
          res.status(400).json({ error: "Publication introuvable." });
        }
      })
      .catch(function (err) {
        res.status(500).json({ err });
      });
};

exports.getCommentaires = (req, res, next) => {
  models.Commentaire.findAll({
    include: models.User,
    where: {status: 0},
  })
    .then(function (commentaire) {
      if (commentaire) {
        res.status(200).json({ commentaire });
      } else {
        res.status(400).json({ error: "Publication introuvable." });
      }
    })
    .catch(function (err) {
      res.status(500).json({ err });
    });
};

exports.modifyMessage = (req, res, next) => {
  const token = req.headers.authorization;
  const decodedToken = jwt.verify(token, `${process.env.SECRET_KEY}`);
  const userId = decodedToken.userId;

  let status = req.body.status;
  let publicationId = req.params.id;
  
  models.User.findOne({
    where: {id: userId}
  })
  .then(function(user){
    if (user.isAdmin === true){
      models.Publication.findOne({
        include: models.User,
        where: { id: publicationId },
      })
      .then(function (publicationFound) {
        publicationFound.update({
            status: true,
          })
          .then(res.status(201).json({ message: "Mise à jour effectué." }));
      })
      .catch(function (err) {
        res
          .status(400)
          .json(console.log(err));
      });
    } else {
      res.status(403).json({ message : "Vous n'êtes pas autorisé à effectuer cette requête."})
    }
  })
};

exports.modifyComment = (req, res, next) => {
  const token = req.headers.authorization;
  const decodedToken = jwt.verify(token, `${process.env.SECRET_KEY}`);
  const userId = decodedToken.userId;

  let status = req.body.status;
  let commentaireId = req.params.id;
  
  models.User.findOne({
    where: {id: userId}
  })
  .then(function(user){
    if (user.isAdmin === true){
      models.Commentaire.findOne({
        include: models.User,
        where: { id: commentaireId },
      })
      .then(function (commentaireFound) {
        commentaireFound.update({
            status: true,
          })
          .then(res.status(201).json({ message: "Mise à jour effectué." }));
      })
      .catch(function (err) {
        res
          .status(400)
          .json(console.log(err));
      });
    } else {
      res.status(403).json({ message : "Vous n'êtes pas autorisé à effectuer cette requête."})
    }
  })
};