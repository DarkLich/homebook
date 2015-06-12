couch = require('./couch')

shops_db = couch.getDb('h_shops', ()->
  shops_db.save '_design/all',
    all: map: (doc)->
      if (doc.title)
        emit(doc._id, null)
  return
)

module.exports.shops = shops_db