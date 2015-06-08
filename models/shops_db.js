// Generated by CoffeeScript 1.9.1
(function() {
  var couch, shops_db;

  couch = require('./couch');

  shops_db = couch.connection.database('h_shops');

  shops_db.exists(function(err, exists) {
    if (err) {
      return console.log('error', err);
    } else if (exists) {
      return console.log('the force is with you.');
    } else {
      console.log('database does not exists.');
      shops_db.create(function(err) {
        if (err) {
          return console.log('не удалось создать базу h_shops');
        }
      });
      return shops_db.save('_design/all', {
        all: {
          map: function(doc) {
            if (doc.title) {
              return emit(doc._id, null);
            }
          }
        }
      });
    }
  });

  module.exports.shops = shops_db;

}).call(this);