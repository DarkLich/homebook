couch = require('./couch')

purchases_db = couch.connection.database('h_purchases')

purchases_db.exists (err, exists)->
  if err
    console.log 'error', err
  else if exists
    console.log 'the force is with you.'
  else
    console.log 'database does not exists.'
    purchases_db.create((err)->
      if err
        console.log 'не удалось создать базу h_purchases'
#        console.log err
    )

module.exports.purchases = purchases_db