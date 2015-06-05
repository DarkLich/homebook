'use strict'

passport = require('passport')
# End of dependencies.

module.exports = (req, res, next) ->
  console.log 'someone trying to login'
  passport.authenticate('local', (err, user, info) ->
    console.log 'err:', err
    console.log 'user:', user
    console.log 'info:', info
    if err
#      next(err)
      return res.render('user/login', { error: 'Пользователь не найден' })
    if !user
      req.session.messages = info.message
      return res.render('user/login', { error: 'Неверный пароль' })

    req.logIn(user, ((err) ->
      if err
        req.session.messages = "Error"
        return next(err)

      req.session.messages = "Login successfully"
      return res.redirect('/')
    ))
  ) req, res, next
  return