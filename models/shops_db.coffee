couch = require('./couch')

shops_db = couch.connection.database('h_shops')

shops_db.exists (err, exists)->
  if err
    console.log 'error', err
  else if exists
    console.log 'the force is with you.'
  else
    console.log 'database does not exists.'
    shops_db.create((err)->
      if err
        console.log 'не удалось создать базу h_shops'
#        console.log err
    )

    shops_db.save '_design/all',
      all: map: (doc)->
        if (doc.title)
          emit(doc._id, null)



module.exports.shops = shops_db