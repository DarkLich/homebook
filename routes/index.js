// Generated by CoffeeScript 1.9.1
(function() {
  var express, router;

  express = require('express');

  router = express.Router();


  /* GET home page. */

  router.get('/', function(req, res, next) {
    res.render('index');
  });

  module.exports = router;

}).call(this);
