'use strict'

categories_db = require('../../models/categories_db')
io = require('../io')
_ = require('lodash')

module.exports = (req, res, next) ->
  category = req.body

  categories_db.categories.view 'byTitle/byTitle', {key: req.body.title, include_docs: true}, (err, docs)->
    if docs.length > 0
      io.show('категория'+req.body.title+'уже существует', 'error')
    else
      categories_db.categories.save category, (err, res) ->
        if err
          io.show('ошибка при создании категории'+req.body.title, 'error', err)
        else
          io.show('категория ' + req.body.title + ' успешно создана', 'success')
    #    console.log res

    #    Handle response
        return

  next()
  return