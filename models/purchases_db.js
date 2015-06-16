// Generated by CoffeeScript 1.9.1
(function() {
  var couch, purchases_db;

  couch = require('./couch');

  purchases_db = couch.getDb('h_purchases', function() {
    purchases_db.save('_design/all', {
      all: {
        map: function(doc) {
          return emit(doc.date, null);
        }
      }
    });
  });

  module.exports = purchases_db;

}).call(this);
