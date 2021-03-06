// Generated by CoffeeScript 1.9.1
(function() {
  var category, express, router;

  express = require('express');

  router = express.Router();

  category = require('../controllers/categories');

  router.use('/*', function(req, res, next) {
    if (!req.user) {
      res.redirect('/user/login');
    } else {
      next();
    }
  });

  router.get('/create', function(req, res, next) {
    console.log('restart');
    res.render('category/create');
  });

  router.post('/create', category.create, function(req, res, next) {
    res.send(res.body);
  });

  module.exports = router;

}).call(this);
