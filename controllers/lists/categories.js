// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var _, categories_db;

  _ = require('lodash');

  categories_db = require('../../models/categories_db');

  module.exports = function(req, res, next) {
    categories_db.view('all/all', {
      include_docs: true
    }, function(err, docs) {
      var items;
      items = [];
      _.each(docs, function(val) {
        return items.push({
          name: val.doc.title,
          id: val.id,
          kind: val.doc.kind
        });
      });
      return res.send(items);
    });
    next();
  };

}).call(this);
