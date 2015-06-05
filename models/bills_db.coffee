couch = require('./couch')

bills_db = couch.connection.database('h_bills')
#
bills_db.exists (err, exists)->
  if err
    console.log 'error', err
  else if exists
    console.log 'the force is with you.'
  else
    console.log 'database does not exists.'
    bills_db.create((err)->
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
module.exports.bills = bills_db