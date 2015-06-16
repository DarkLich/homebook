express = require('express')
router = express.Router()
admin = require('../controllers/admin')

## Доступ к админ-действиям только для залогиненых юзеров
router.use '/*', (req, res, next) ->
  if not req.user
    res.redirect '/user/login'
  else
    next()
  return

router.get '/restart', admin.restart, (req, res, next) ->
  console.log 'route restart'
  res.redirect '/'
  return

router.get '/replicate/to', admin.replicateTo, (req, res, next) ->
  console.log 'route replicate to'
  res.redirect '/'
  return

router.get '/replicate/from', admin.replicateFrom, (req, res, next) ->
  console.log 'route replicate from'
  res.redirect '/'
  return

router.get '/base/clear', admin.clearBase, (req, res, next) ->
  console.log 'route clearBase'
  res.redirect '/'
  return

module.exports = router