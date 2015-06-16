express = require('express')
router = express.Router()
purchases = require('../controllers/purchases')

# Доступ к чекам только для залогиненых юзеров
#router.use '/*', (req, res, next) ->
#  if not req.user
#    res.redirect '/user/login'
#  else
#    next()
#  return


#router.get '/create', (req, res, next) ->
##  console.log 'get'
#  res.render '/create'
#  return

router.get '/all', purchases.all, (req, res, next) ->
  console.log 'get all'
  res.render 'purchase/all'
  return


module.exports = router
