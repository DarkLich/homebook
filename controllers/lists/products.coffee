'use strict'
_ = require('lodash')
products_db = require('../../models/products_db')

module.exports = (req, res, next) ->
  products_db.products.view 'all/all', {include_docs: true}, (err, docs)->
    items = []
    _.each docs, (val)->
      items.push
        name: val.doc.title
        id: val.id
    res.send items

  next()
  return
