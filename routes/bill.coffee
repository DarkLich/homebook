express = require('express')
router = express.Router()
bills = require('../controllers/bills')

### GET users listing. ###

router.get '/create', (req, res, next) ->
  console.log 'get'
  res.render 'bill/create', a:'s'
  return

#router.post '/create', bills.create, (req, res, next) ->
#  res.render 'index'
#  return

module.exports = router
