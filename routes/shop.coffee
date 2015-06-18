express = require('express')
router = express.Router()
shops = require('../controllers/shops')

## Доступ к админ-действиям только для залогиненых юзеров
router.use '/*', (req, res, next) ->
  if not req.user
    res.redirect '/user/login'
  else
    next()
  return

router.get '/create', (req, res, next) ->
  res.render 'shop/create'
  return

router.post '/create', shops.create, (req, res, next) ->
  res.send res.body
  return

module.exports = router
