// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var _, products_db;

  _ = require('lodash');

  products_db = require('../../models/products_db');

  module.exports = function(req, res, next) {
    products_db.products.view('all/all', {
      include_docs: true
    }, function(err, docs) {
      var items;
      items = [];
      _.each(docs, function(val) {
        return items.push({
          name: val.doc.title,
          id: val.id
        });
      });
      return res.send(items);
    });
    next();
  };

}).call(this);
