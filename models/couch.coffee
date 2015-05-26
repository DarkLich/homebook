express = require('express')
cradle = require('cradle')
console.log 'hhhhhhhhhhhh'
couch = ->
  con = new(cradle.Connection)('http://localhost', 5984,
    cache: true
    raw: false
    forceSave: true
    auth: { username: 'root', password: 'StrongPassWord' }
  )
#  console.log con
  db = con.database('starwars')
  db.create((err)->
    console.log 'err'
    console.log err
  )

  db.save 'vader', {
    name: 'darth'
    force: 'dark'
  }, (err, res) ->
    # Handle response
    return

  db.exists (err, exists)->
    if err
      console.log 'error', err
    else if exists
      console.log 'the force is with you.'
    else
      console.log 'database does not exists.'
      db.create()

    ### populate design documents ###

    return
module.exports = couch