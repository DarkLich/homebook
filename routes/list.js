// Generated by CoffeeScript 1.9.1
(function() {
  var express, lists, router;

  express = require('express');

  router = express.Router();

  lists = require('../controllers/lists');

  router.get('/products', lists.products, function(req, res, next) {});

  module.exports = router;

}).call(this);
