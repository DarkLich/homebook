express = require('express')
cradle = require('cradle_security')({
  debug: true
#  adminUsername: "root"
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
  auth: { username: 'root', password: 'StrongPassWord' }
)

getDb = (db_name, cb)->
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


module.exports.getDb = getDb