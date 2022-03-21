const express = require('express');
const router = express.Router();
const adminCtrl = require('../controllers/admin');
const multer = require('../middleware/multer-config');

router.get('/', multer, adminCtrl.getPublications);
router.get('/commentaire', adminCtrl.getCommentaires);
router.put('/updatestatus/:id', adminCtrl.modifyMessage);
router.put('/updatestatuscomment/:id', adminCtrl.modifyComment);

module.exports = router;