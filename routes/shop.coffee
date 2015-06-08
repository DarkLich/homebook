express = require('express')
router = express.Router()
shops = require('../controllers/shops')

#router.get '/create', (req, res, next) ->
#  res.render 'shop/create'
#  return
#
#router.post '/create', shops.create, (req, res, next) ->
#  res.render 'shop/create'
#  return

module.exports = router
