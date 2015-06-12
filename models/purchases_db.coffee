couch = require('./couch')

purchases_db = couch.getDb('h_purchases', ()->
  return
)

module.exports.purchases = purchases_db