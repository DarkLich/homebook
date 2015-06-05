'use strict'

###*
# Module dependencies.
###

couch = require('../../models/couch')
#db = new couch
# End of dependencies.

module.exports = (req, res, next) ->
  console.log(req.body.email)
  couch.users.get(req.body.email,(err, doc)->
    if err and err.error is 'not_found' #если такой юзер еще не зарегистрирован
      couch.users.save req.body.email, {
        email: req.body.email
        password: req.body.password
      }, (err, res) ->
        # Handle response
        return
  )
  next()
  return