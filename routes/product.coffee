express = require('express')
router = express.Router()
products = require('../controllers/products')

## Доступ к админ-действиям только для залогиненых юзеров
router.use '/*', (req, res, next) ->
  if not req.user
    res.redirect '/user/login'
  else
    next()
  return

router.get '/create', (req, res, next) ->
#  console.log 'get'
  res.render 'product/create'
  return
#
router.post '/create', products.create, (req, res, next) ->
  res.send(res.body)
  return

module.exports = router
