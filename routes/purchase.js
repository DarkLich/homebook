// Generated by CoffeeScript 1.9.1
(function() {
  var express, purchases, router;

  express = require('express');

  router = express.Router();

  purchases = require('../controllers/purchases');

  router.use('/*', function(req, res, next) {
    if (!req.user) {
      res.redirect('/user/login');
    } else {
      next();
    }
  });

  router.get('/all', purchases.all, function(req, res, next) {
    console.log('get all');
    res.render('purchase/all');
  });

  module.exports = router;

}).call(this);
