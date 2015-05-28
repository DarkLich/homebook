express = require('express')
cradle = require('cradle')

module.exports.init = (opts)->
  con = new(cradle.Connection)('http://localhost', 5984,
    cache: true
    raw: false
    forceSave: true
    auth: { username: 'root', password: 'StrongPassWord' }
  )

  users_db = con.database('h_users')

  users_db.exists (err, exists)->
    if err
      console.log 'error', err
    else if exists
      console.log 'the force is with you.'
    else
      console.log 'database does not exists.'
      users_db.create((err)->
        if err
          console.log 'не удалось создать базу h_users'
          console.log err
      )

#  db.save 'vader', {
#    name: 'admin'
#    pass: 'dark'
#  }, (err, res) ->
#    # Handle response
#    return

  module.exports.users = users_db

  return
#module.exports = couch