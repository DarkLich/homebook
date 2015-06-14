express = require('express')
path = require('path')
favicon = require('serve-favicon')
morgan = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
session = require('express-session')
passport = require('passport')
routes = require('./routes/index')
list = require('./routes/list')
user = require('./routes/user')
bill = require('./routes/bill')
product = require('./routes/product')
shop = require('./routes/shop')
admin = require('./routes/admin')
fs = require('fs')

app = express()
# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));

#app.use morgan('dev')
if (!fs.existsSync(__dirname + '/logs'))
  fs.mkdirSync(__dirname + '/logs')
accessLogStream = fs.createWriteStream(__dirname + '/logs/access.log', {flags: 'a'})
app.use(morgan('combined', {stream: accessLogStream}))

app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))
#app.use(bodyParser);
app.use session(
  secret: 'SECRET'
  resave: true
  saveUninitialized: true)
#
app.use passport.initialize()
app.use passport.session()
# Для проверки авторизации в темплейтах
app.use (req, res, next) ->
  res.locals.app_version = '0.0.4'
  res.locals.user = req.user
  #res.locals.login = req.isAuthenticated();
  if req.user
    res.locals.isAdmin = req.user.email is 'dark-lich@inbox.ru'
  next()
  return
app.use '/', routes
app.use '/admin', admin
app.use '/list', list
app.use '/user', user
app.use '/bill', bill
app.use '/product', product
app.use '/shop', shop
# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return
# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
    return
# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
  return
module.exports = app
