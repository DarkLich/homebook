express = require('express')
router = express.Router()
category = require('../controllers/categories')

## Доступ к админ-действиям только для залогиненых юзеров
#router.use '/*', (req, res, next) ->
#  if not req.user
#    res.redirect '/user/login'
#  else
#    next()
#  return

router.get '/create', (req, res, next) ->
  console.log 'restart'
  res.render 'category/create'
  return

router.post '/create', category.create, (req, res, next) ->
  res.send(res.body)
  return


module.exports = router