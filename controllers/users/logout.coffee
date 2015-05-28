'use strict'

###*
# Module dependencies.
###

# End of dependencies.

module.exports = (req, res) ->
  req.logout()
  res.redirect '/'
  return