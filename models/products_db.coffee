couch = require('./couch')

products_db = couch.connection.database('h_products')

products_db.exists (err, exists)->
  if err
    console.log 'error', err
  else if exists
    console.log 'the force is with you.'
  else
    console.log 'database does not exists.'
    products_db.create((err)->
      if err
        console.log 'не удалось создать базу h_products'
#        console.log err


    )

    products_db.save '_design/all',
      all: map: (doc)->
        if (doc.title)
          emit(doc._id, null)



module.exports.products = products_db