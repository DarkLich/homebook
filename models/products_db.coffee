couch = require('./couch')

products_db = couch.getDb('h_products', ()->
  products_db.save '_design/all',
    all: map: (doc)->
      if (doc.title)
        emit(doc.title, null)
  return
)

module.exports = products_db