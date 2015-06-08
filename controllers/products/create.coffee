'use strict'

products_db = require('../../models/products_db')

module.exports = (req, res, next) ->
  console.log 'CREATION'
  console.log(req.body)

  product = req.body

  products_db.products.save product, (err, res) ->
    console.log res

    # Handle response
    return

  next()
  return