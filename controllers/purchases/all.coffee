'use strict'

_ = require('lodash')
purchases_db = require('../../models/purchases_db')
io = require('../io')

module.exports = (req, response, next)->
  purchase_items = []
  purchases_db.view 'all/all', {include_docs: true}, (err, res)->
    console.log res
    _.each res, (row)->
      purchase_items.push({
        id: row.id
        doc: row.doc
      })
    response.locals.purchases = purchase_items
    next()
    return
  return
