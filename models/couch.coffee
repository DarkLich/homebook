express = require('express')
_ = require('lodash')

adminUsername = 'root'
adminPassword = 'StrongPassWord'

cradle = require('cradle_security')({
  debug: true
#  adminUsername: adminUsername
#  adminPassword: "StrongPassWord"
})

cradle.setup({
  host: 'http://localhost'
  port: 5984
  cache: true
  raw: false
  forceSave: true
})

con = new(cradle.Connection)(
  auth: { username: adminUsername, password: adminPassword }
)

getDb = (db_name, cb)->
  if typeof cb isnt 'function'
    cb = ->
      console.log 'getDb callback not provided'
  db = con.database(db_name)

  db.exists (err, exists)->
    if err
      console.log 'error', err
    else if exists
      console.log 'the force is with you.'
      cb()
    else
      console.log 'database does not exists.'
      db.create((create_err)->
        if create_err
          console.log 'не удалось создать базу' + db_name
          console.log create_err
        else
          # роли пользователей с доступом к бд
          db.save '_security',
            readers: {
              roles: ['ROLE_USER']
            }
          cb()
        return
      )
    return

  return db

replicateTo = ()->
  remote_admin_username = adminUsername
  remote_admin_password = adminPassword

  replicateBases = ['h_products','h_shops','h_purchases','h_bills']

  console.log '-----------start_replicate_to-----------'
  _.each replicateBases, (base)->
    con.replicate {source: base, target:"http://"+remote_admin_username+":"+remote_admin_password+"@puppet.ingenuity.net.au:5984/"+base},(err,result)->
      console.log 'replicateTo error:', err
      console.log 'replicateTo result:', result
  console.log '----------finish_replicate_to-----------'
  return

replicateFrom = ()->
  remote_admin_username = adminUsername
  remote_admin_password = adminPassword

  replicateBases = ['h_products','h_shops','h_purchases','h_bills']

  console.log '-----------start_replicate_from-----------'
  _.each replicateBases, (base)->
    con.replicate {source: "http://"+remote_admin_username+":"+remote_admin_password+"@puppet.ingenuity.net.au:5984/"+base, target: base},(err,result)->
      console.log 'replicateFrom error:', err
      console.log 'replicateFrom result:', result
  console.log '----------finish_replicate_from-----------'
  return

module.exports.getDb = getDb
module.exports.replicateTo = replicateTo
module.exports.replicateFrom = replicateFrom