express = require('express')
cradle = require('cradle')

con = null
con = new(cradle.Connection)('http://localhost', 5984,
  cache: true
  raw: false
  forceSave: true
  auth: { username: 'root', password: 'StrongPassWord' }
)

module.exports.connection = con