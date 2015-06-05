express = require('express')
router = express.Router()
users = require('../controllers/users')

### GET users listing. ###

requireAuth = (req, res, next) ->
  # check if the user is logged in
  console.log req.isAuthenticated()
  if !req.isAuthenticated()
    req.session.messages = 'You need to login to view this page'
    res.redirect '/user/login'
  else
    next()
  return

adminHandler = (req, res, next) ->
  console.log 'ADMIN!!!!!'
  console.log req.user
  return

router.post '/login', users.login, (req, res, next) ->
  res.render 'index', title: 'Express'
  return
router.get '/login', (req, res, next) ->
  res.render 'user/login', title: 'Express'
  return
router.get '/register', (req, res, next) ->
  res.render 'user/register', title: 'Express'
  return
router.post '/register', users.register, (req, res, next) ->
  res.render 'index', title: 'Express'
  return
router.get '/logout', users.logout
router.get '/fail', (req, res, next) ->
  res.render 'user/fail', title: 'Express'
  return
router.get '/admin', requireAuth, adminHandler
module.exports = router
