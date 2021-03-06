// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var _, shops_db;

  _ = require('lodash');

  shops_db = require('../../models/shops_db');

  module.exports = function(req, res, next) {
    shops_db.view('all/all', {
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
