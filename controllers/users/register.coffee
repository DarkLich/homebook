'use strict'

users_db = require('../../models/users_db')

module.exports = (req, res, next) ->
#  console.log(req.body.email)
  users_db.users.get(req.body.email,(err, doc)->
    if err and err.error is 'not_found' #если такой юзер еще не зарегистрирован
      users_db.users.save req.body.email, {
        email: req.body.email
        name: req.body.email
        password: req.body.password
        roles: ['ROLE_USER']
        type: 'user'
      }, (err, res) ->
        # Handle response
        return

      # дополнительно создаем юзера для аутентификации
      users_db.users.addUser req.body.email, req.body.password, [ 'ROLE_USER' ], (err, res) ->
        console.log res
        return
  )
  next()
  return