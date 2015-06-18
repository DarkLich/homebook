express = require('express')
router = express.Router()
bills = require('../controllers/bills')

# Доступ к чекам только для залогиненых юзеров
router.use '/*', (req, res, next) ->
  if not req.user
    res.redirect '/user/login'
  else
    next()
  return


router.get '/create', (req, res, next) ->
#  console.log 'get'
  res.render 'bill/create'
  return

router.get '/all', bills.all, (req, res, next) ->
  console.log 'get all'
  res.render 'bill/all'
  return

router.post '/create', bills.create, (req, res, next) ->
  res.send res.body
  return

module.exports = router
