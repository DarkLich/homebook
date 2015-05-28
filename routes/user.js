var express = require('express');
var router = express.Router();

var users = require('../controllers/users');

/* GET users listing. */
router.post('/login', users.login,
    function(req, res, next) {
        res.render('index', {title: 'Express', username: req.user.username});
    });

router.get('/login', function(req, res, next) {
    res.render('user/login', { title: 'Express' })
});

router.get('/register', function(req, res, next) {
    res.render('user/register', { title: 'Express' })
});
router.post('/register', users.register,
    function(req, res, next) {
    res.render('index', { title: 'Express', username: req.user.username });
});
router.get('/logout', users.logout);

router.get('/fail', function(req, res, next) {
    res.render('user/fail', { title: 'Express' })
});

router.get('/admin', requireAuth, adminHandler);

function requireAuth(req, res, next){

    // check if the user is logged in
    console.log (req.isAuthenticated())
    if(!req.isAuthenticated()){
        req.session.messages = "You need to login to view this page"
        res.redirect('/user/login')
    } else {
        next()
    }
}

function adminHandler(req, res, next){
    console.log ('ADMIN!!!!!')
    console.log (req.user);
}

module.exports = router;
