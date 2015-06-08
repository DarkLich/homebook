// Generated by CoffeeScript 1.9.1
(function() {
  var couch, users_db;

  couch = require('./couch');

  users_db = couch.connection.database('h_users');

  users_db.exists(function(err, exists) {
    if (err) {
      return console.log('error', err);
    } else if (exists) {
      return console.log('the force is with you.');
    } else {
      console.log('database does not exists.');
      return users_db.create(function(err) {
        if (err) {
          return console.log('не удалось создать базу h_users');
        }
      });
    }
  });

  module.exports.users = users_db;

}).call(this);
