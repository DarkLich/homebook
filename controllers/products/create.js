// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var products_db;

  products_db = require('../../models/products_db');

  module.exports = function(req, res, next) {
    var product;
    console.log('CREATION');
    console.log(req.body);
    product = req.body;
    products_db.products.save(product, function(err, res) {
      console.log(res);
    });
    next();
  };

}).call(this);
