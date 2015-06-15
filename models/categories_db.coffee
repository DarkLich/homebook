couch = require('./couch')

categories_db = couch.getDb('h_categories', ()->
  categories_db.save '_design/all',
    all: map: (doc)->
      if (doc.title)
        emit(doc._id, null)
  categories_db.save '_design/byTitle',
    byTitle: map: (doc)->
      emit(doc.title, null)
  return
)

module.exports.categories = categories_db