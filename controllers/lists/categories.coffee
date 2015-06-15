'use strict'
_ = require('lodash')
categories_db = require('../../models/categories_db')

module.exports = (req, res, next)->
  categories_db.categories.view 'all/all', {include_docs: true}, (err, docs)->
    items = []
    _.each docs, (val)->
      items.push
        name: val.doc.title
        id: val.id
    res.send items

  next()
  return
