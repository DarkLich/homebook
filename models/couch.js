// Generated by CoffeeScript 1.9.1
(function() {
  var _, adminPassword, adminUsername, allBases, clearBase, con, cradle, express, getDb, replicateBases, replicateFrom, replicateTo;

  express = require('express');

  _ = require('lodash');

  adminUsername = 'root';

  adminPassword = 'StrongPassWord';

  allBases = ['h_users', 'h_products', 'h_shops', 'h_purchases', 'h_bills', 'h_categories'];

  replicateBases = ['h_products', 'h_shops', 'h_purchases', 'h_bills', 'h_categories'];

  cradle = require('cradle_security')({
    debug: true
  });

  cradle.setup({
    host: 'http://localhost',
    port: 5984,
    cache: true,
    raw: false,
    forceSave: true
  });

  con = new cradle.Connection({
    auth: {
      username: adminUsername,
      password: adminPassword
    }
  });

  getDb = function(db_name, cb) {
    var db;
    if (typeof cb !== 'function') {
      cb = function() {
        return console.log('getDb callback not provided');
      };
    }
    db = con.database(db_name);
    db.exists(function(err, exists) {
      if (err) {
        console.log('error', err);
      } else if (exists) {
        console.log('the force is with you.');
        cb();
      } else {
        console.log('database does not exists.');
        db.create(function(create_err) {
          if (create_err) {
            console.log('не удалось создать базу' + db_name);
            console.log(create_err);
          } else {
            db.save('_security', {
              readers: {
                roles: ['ROLE_USER']
              }
            });
            cb();
          }
        });
      }
    });
    return db;
  };

  replicateTo = function() {
    var remote_admin_password, remote_admin_username;
    remote_admin_username = adminUsername;
    remote_admin_password = adminPassword;
    console.log('-----------start_replicate_to-----------');
    _.each(replicateBases, function(base) {
      return con.replicate({
        source: base,
        target: "http://" + remote_admin_username + ":" + remote_admin_password + "@puppet.ingenuity.net.au:5984/" + base
      }, function(err, result) {
        console.log('replicateTo error:', err);
        return console.log('replicateTo result:', result);
      });
    });
    console.log('----------finish_replicate_to-----------');
  };

  replicateFrom = function() {
    var remote_admin_password, remote_admin_username;
    remote_admin_username = adminUsername;
    remote_admin_password = adminPassword;
    console.log('-----------start_replicate_from-----------');
    _.each(replicateBases, function(base) {
      return con.replicate({
        source: "http://" + remote_admin_username + ":" + remote_admin_password + "@puppet.ingenuity.net.au:5984/" + base,
        target: base
      }, function(err, result) {
        console.log('replicateFrom error:', err);
        return console.log('replicateFrom result:', result);
      });
    });
    console.log('----------finish_replicate_from-----------');
  };

  clearBase = function() {
    return _.each(replicateBases, function(base) {
      var db;
      db = con.database(base);
      return db.destroy(function(err, res) {
        getDb(base, function() {
          return console.log('created');
        });
        console.log('destroy db');
        console.log(err);
        return console.log(res);
      });
    });
  };

  module.exports.getDb = getDb;

  module.exports.replicateTo = replicateTo;

  module.exports.replicateFrom = replicateFrom;

  module.exports.clearBase = clearBase;

}).call(this);
