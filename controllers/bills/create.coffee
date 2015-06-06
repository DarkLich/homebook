'use strict'

###*
# Module dependencies.
###

bills_db = require('../../models/bills_db')
#db = new couch
# End of dependencies.

module.exports = (req, res, next) ->
  console.log(req.body)

#  bills_db.users.save req.body.email, {
#    email: req.body.email
#    password: req.body.password
#  }, (err, res) ->
#    # Handle response
#    return

  next()
  return