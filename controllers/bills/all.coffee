'use strict'

_ = require('lodash')
bills_db = require('../../models/bills_db')
#purchases_db = require('../../models/purchases_db')
io = require('../io')

module.exports = (req, response, next)->
  bill_items = []
  bills_db.view 'all/all', {include_docs: true}, (err, res)->
    console.log res
    _.each res, (row)->
      bill_items.push({
        id: row.id
        doc: row.doc
      })
    console.log bill_items
    response.locals.bills = bill_items
    next()
    return
  return
