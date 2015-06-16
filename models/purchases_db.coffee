couch = require('./couch')

purchases_db = couch.getDb('h_purchases', ()->
  purchases_db.save '_design/all',
    all: map: (doc)->
      emit(doc.date, null)
  return
)

module.exports = purchases_db