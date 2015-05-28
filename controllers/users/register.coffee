'use strict'

###*
# Module dependencies.
###

couch = require('../../models/couch')
#db = new couch
# End of dependencies.

module.exports = (req, res, next) ->
  console.log(req.body.username)
  couch.users.get(req.body.username,(err, doc)->
    if err and err.error is 'not_found' #если такой юзер еще не зарегистрирован
      couch.users.save req.body.username, {
        username: req.body.username
        password: req.body.password
      }, (err, res) ->
        # Handle response
        return
  )
  next()
  return