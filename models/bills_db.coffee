couch = require('./couch')

bills_db = couch.getDb('h_bills', ()->
  bills_db.save '_design/all',
    all: map: (doc)->
      emit(doc.date, null)
  return
)

module.exports = bills_db