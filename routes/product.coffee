express = require('express')
router = express.Router()
products = require('../controllers/products')

router.get '/create', (req, res, next) ->
#  console.log 'get'
  res.render 'product/create'
  return
#
router.post '/create', products.create, (req, res, next) ->
  res.send(res.body)
  return

module.exports = router
