'use strict'

shops_db = require('../../models/shops_db')

module.exports = (req, res, next) ->
  console.log 'CREATION'
  console.log(req.body)

  shop = req.body

  shops_db.shops.save shop, (err, res) ->
    console.log res

    # Handle response
    return

  next()
  return