couch = require('./couch')

users_db = couch.getDb('h_users', ()->
  return
)

module.exports.users = users_db