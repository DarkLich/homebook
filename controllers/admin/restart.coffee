'use strict'

spawn = require('child_process')
_ = require('lodash')

module.exports = (req, res, next) ->
  if req.user
    spawn.exec 'sudo /usr/sbin/service homebook restart', (error, stdout, stderr) ->
      console.log 'stdout: ' + stdout
      console.log 'stderr: ' + stderr
      if error != null
        console.log 'exec error: ' + error
      return

  next()
  return
