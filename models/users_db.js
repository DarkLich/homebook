// Generated by CoffeeScript 1.9.1
(function() {
  var couch, users_db;

  couch = require('./couch');

  users_db = couch.getDb('h_users', function() {});

  module.exports = users_db;

}).call(this);
