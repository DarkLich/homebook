express = require('express')
cradle = require('cradle')

con = null
#module.exports.init = (opts)->
con = new(cradle.Connection)('http://localhost', 5984,
  cache: true
  raw: false
  forceSave: true
  auth: { username: 'root', password: 'StrongPassWord' }
)

#return

module.exports.connection = con
#module.exports = couch