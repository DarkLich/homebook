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
  console.log 'restart'
  res.redirect '/'
  return

router.get '/replicate/to', admin.replicateTo, (req, res, next) ->
  console.log 'replicate'
  res.redirect '/'
  return

module.exports = router