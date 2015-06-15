'use strict'

products_db = require('../../models/products_db')

module.exports = (req, res, next) ->
  err = null
  product = req.body
  if req.body.title
    if req.body.category and !req.body.category_id
      err = next(new Error('category_id not provided'))
    else
      products_db.products.save product, (err, res) ->
        console.log res

      # Handle response
        return
  else
    err = next(new Error('title not provided'))

  if err
    next(err)
  else
    next()
  return