// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var users_db;

  users_db = require('../../models/users_db');

  module.exports = function(req, res, next) {
    users_db.users.get(req.body.email, function(err, doc) {
      if (err && err.error === 'not_found') {
        return users_db.users.save(req.body.email, {
          email: req.body.email,
          password: req.body.password
        }, function(err, res) {});
      }
    });
    next();
  };

}).call(this);
