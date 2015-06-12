couch = require('./couch')

bills_db = couch.getDb('h_bills', ()->
  return
)

module.exports.bills = bills_db