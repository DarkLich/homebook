// Generated by CoffeeScript 1.9.1
(function() {
  var express, router, shops;

  express = require('express');

  router = express.Router();

  shops = require('../controllers/shops');

  router.use('/*', function(req, res, next) {
    if (!req.user) {
      res.redirect('/user/login');
    } else {
      next();
    }
  });

  router.get('/create', function(req, res, next) {
    res.render('shop/create');
  });

  router.post('/create', shops.create, function(req, res, next) {
    res.send(res.body);
  });

  module.exports = router;

}).call(this);
