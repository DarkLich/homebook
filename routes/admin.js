// Generated by CoffeeScript 1.9.1
(function() {
  var admin, express, router;

  express = require('express');

  router = express.Router();

  admin = require('../controllers/admin');

  router.use('/*', function(req, res, next) {
    if (!req.user) {
      res.redirect('/user/login');
    } else {
      next();
    }
  });

  router.get('/restart', admin.restart, function(req, res, next) {
    console.log('route restart');
    res.redirect('/');
  });

  router.get('/replicate/to', admin.replicateTo, function(req, res, next) {
    console.log('route replicate to');
    res.redirect('/');
  });

  router.get('/replicate/from', admin.replicateFrom, function(req, res, next) {
    console.log('route replicate from');
    res.redirect('/');
  });

  router.get('/base/clear', admin.clearBase, function(req, res, next) {
    console.log('route clearBase');
    res.redirect('/');
  });

  module.exports = router;

}).call(this);
