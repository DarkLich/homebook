// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var passport;

  passport = require('passport');

  module.exports = function(req, res, next) {
    console.log('someone trying to login');
    passport.authenticate('local', function(err, user, info) {
      console.log('err:', err);
      console.log('user:', user);
      console.log('info:', info);
      if (err) {
        return res.render('user/login', {
          error: 'Пользователь не найден'
        });
      }
      if (!user) {
        req.session.messages = info.message;
        return res.render('user/login', {
          error: 'Неверный пароль'
        });
      }
      return req.logIn(user, (function(err) {
        if (err) {
          req.session.messages = "Error";
          return next(err);
        }
        req.session.messages = "Login successfully";
        return res.redirect('/');
      }));
    })(req, res, next);
  };

}).call(this);
