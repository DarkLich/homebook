couch = require('./couch')

users_db = couch.connection.database('h_users')
#
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