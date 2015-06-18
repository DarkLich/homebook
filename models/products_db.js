// Generated by CoffeeScript 1.9.1
(function() {
  var couch, products_db;

  couch = require('./couch');

  products_db = couch.getDb('h_products', function() {
    products_db.save('_design/all', {
      all: {
        map: function(doc) {
          if (doc.title) {
            return emit(doc.title, null);
          }
        }
      }
    });
  });

  module.exports = products_db;

}).call(this);
