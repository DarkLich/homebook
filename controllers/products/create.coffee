'use strict'

products_db = require('../../models/products_db')
io = require('../io')

module.exports = (req, response, next) ->
  product = req.body
  if req.body.title
    if req.body.category and !req.body.category_id
      io.show('не указан класс продукта', 'error')
      response.body = {success: false, err: 'category_id not provided'}
      next()
    else
      products_db.save product, (err, res) ->
        io.show('продукт'+req.body.title+'успешно создан', 'success')
        response.body = {success: true, id: res.id}
        next()
        return
  else
    io.show('не указано наименование продукта', 'error')
    response.body = {success: false, err: 'title not provided'}
    next()

  return