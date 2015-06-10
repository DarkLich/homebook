express = require('express')
router = express.Router()
bills = require('../controllers/bills')

spawn = require('child_process')
_ = require('lodash')

## Доступ к чекам только для залогиненых юзеров
#router.use '/*', (req, res, next) ->
#  if not req.user
#    res.redirect '/user/login'
#  else
#    next()
#  return

router.get '/restart', (req, res, next) ->
  console.log 'restart'
#  res.render 'bill/create'
  #deploySh = spawn('sh', [ 'deploy.sh' ], {
  #  cwd: process.env.HOME + '/myProject',
  #  env:_.extend(process.env, { PATH: process.env.PATH + ':/usr/local/bin' })
  #})

  spawn.exec 'sudo /usr/local/etc/rc.d/homebook restart', (error, stdout, stderr) ->
    console.log 'stdout: ' + stdout
    console.log 'stderr: ' + stderr
    if error != null
      console.log 'exec error: ' + error
    return
  return

module.exports = router