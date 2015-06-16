'use strict'
_ = require('lodash')
shops_db = require('../../models/shops_db')

module.exports = (req, res, next)->
  shops_db.view 'all/all', {include_docs: true}, (err, docs)->
    items = []
    _.each docs, (val)->
      items.push
        name: val.doc.title
        id: val.id
    res.send items

  next()
  return
