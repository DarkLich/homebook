'use strict'

shops_db = require('../../models/shops_db')
io = require('../io')

module.exports = (req, response, next) ->
  shop = req.body

  shops_db.save shop, (err, res) ->
    if err
      return
    io.show('магазин'+req.body.title+'успешно создан', 'success')
    response.body = {success: true, id: res.id}
    next()
    return

  return