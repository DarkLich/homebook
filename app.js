// Generated by CoffeeScript 1.9.1
(function() {
  var accessLogStream, admin, app, bill, bodyParser, category, cookieParser, express, favicon, fs, list, morgan, passport, path, product, purchase, routes, session, shop, user;

  express = require('express');

  path = require('path');

  favicon = require('serve-favicon');

  morgan = require('morgan');

  cookieParser = require('cookie-parser');

  bodyParser = require('body-parser');

  session = require('express-session');

  passport = require('passport');

  routes = require('./routes/index');

  list = require('./routes/list');

  user = require('./routes/user');

  bill = require('./routes/bill');

  product = require('./routes/product');

  shop = require('./routes/shop');

  admin = require('./routes/admin');

  category = require('./routes/category');

  purchase = require('./routes/purchase');

  fs = require('fs');

  app = express();

  app.set('views', path.join(__dirname, 'views'));

  app.set('view engine', 'jade');

  if (!fs.existsSync(__dirname + '/logs')) {
    fs.mkdirSync(__dirname + '/logs');
  }

  accessLogStream = fs.createWriteStream(__dirname + '/logs/access.log', {
    flags: 'a'
  });

  app.use(morgan('combined', {
    stream: accessLogStream
  }));

  app.use(bodyParser.json());

  app.use(bodyParser.urlencoded({
    extended: false
  }));

  app.use(cookieParser());

  app.use(express["static"](path.join(__dirname, 'public')));

  app.use(session({
    secret: 'SECRET',
    resave: true,
    saveUninitialized: true
  }));

  app.use(passport.initialize());

  app.use(passport.session());

  app.use(function(req, res, next) {
    res.locals.app_version = '0.0.5';
    res.locals.user = req.user;
    if (req.user) {
      res.locals.isAdmin = req.user.email === 'dark-lich@inbox.ru';
    }
    next();
  });

  app.use('/', routes);

  app.use('/admin', admin);

  app.use('/list', list);

  app.use('/user', user);

  app.use('/bill', bill);

  app.use('/product', product);

  app.use('/shop', shop);

  app.use('/category', category);

  app.use('/purchase', purchase);

  app.use(function(req, res, next) {
    var err;
    err = new Error('Not Found');
    err.status = 404;
    next(err);
  });

  if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
      res.status(err.status || 500);
      res.render('error', {
        message: err.message,
        error: err
      });
    });
  }

  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: {}
    });
  });

  module.exports = app;

}).call(this);
