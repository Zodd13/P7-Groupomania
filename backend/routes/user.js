const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/user');

router.post('/signup', userCtrl.signup);
router.post('/login', userCtrl.login);
router.get('/profile', userCtrl.profile);
router.put('/update', userCtrl.updateUser);
router.delete('/delete', userCtrl.deleteUser);

module.exports = router;