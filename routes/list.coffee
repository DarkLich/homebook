express = require('express')
router = express.Router()
lists = require('../controllers/lists')

router.get '/products', lists.products, (req, res, next) ->
#  console.log 'get'
#  res.render 'bill/create'
  return

router.get '/shops', lists.shops, (req, res, next) ->
#  console.log 'get'
#  res.render 'bill/create'
  return
#
router.get '/categories', lists.categories, (req, res, next) ->
#  console.log 'get'
#  res.render 'bill/create'
  return

module.exports = router
