'use strict'

passport = require('passport')
# End of dependencies.

module.exports = (req, res, next) ->
  console.log 'someone trying to login'
  passport.authenticate('local', (err, user, info) ->
    console.log 'err:', err
    console.log 'user:', user
    if err
#      next(err)
      return res.redirect('/user/fail')
    if !user
      req.session.messages = info.message
      return res.redirect('/user/fail')

    req.logIn(user, ((err) ->
      if err
        req.session.messages = "Error"
        return next(err)

      req.session.messages = "Login successfully"
      return res.redirect('/')
    ))
  ) req, res, next
  return