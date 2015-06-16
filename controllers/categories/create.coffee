'use strict'

categories_db = require('../../models/categories_db')
io = require('../io')
_ = require('lodash')

module.exports = (req, response, next) ->
  category = req.body

  categories_db.view 'byTitle/byTitle', {key: req.body.title, include_docs: true}, (err, docs)->
    if docs.length > 0
      io.show('категория'+req.body.title+'уже существует', 'error')
      response.body = {success: false}
      next()
    else
      categories_db.save category, (err, res) ->
        if err
          io.show('ошибка при создании категории'+req.body.title, 'error', err)
          response.body = {success: false, err: err}
        else
          io.show('категория ' + req.body.title + ' успешно создана', 'success')
          response.body = {success: true, id: res.id, kind: req.body.kind}
        next()
        return
    return
  return