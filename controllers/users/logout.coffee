'use strict'

###*
# Module dependencies.
###

# End of dependencies.

module.exports = (req, res, next) ->
  req.logout()
  res.redirect '/'
  next()
  return