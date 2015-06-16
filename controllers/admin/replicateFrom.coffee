'use strict'

_ = require('lodash')
couch = require('../../models/couch')

module.exports = (req, res, next) ->
#  if req.user
  couch.replicateFrom()

  next()
  return
