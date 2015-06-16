'use strict'

couch = require('../../models/couch')

module.exports = (req, res, next) ->
#  if req.user
  couch.clearBase()

  next()
  return
