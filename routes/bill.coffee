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

router.post '/create', bills.create, (req, res, next) ->
  res.render 'bill/create'
  return

module.exports = router
