couch = require('../models/couch')

console.log 'name_______'

couch.init()
passport = require('passport')
LocalStrategy = require('passport-local').Strategy
passport.use new LocalStrategy({
    usernameField: 'username'
    passwordField: 'password'
  }, (username, password, done) ->
    console.log 'PASSSPORT'
    console.log username
    console.log password
    couch.users.get username, (err, doc) ->
#      console.log '!doc!'
#      console.log doc
      if err
        done(err)
      else if doc
        if password is doc.password
          done(null, doc)
        else
          done(null, false, message: 'Incorrect password.')
      else
        done(null, false, message: 'Incorrect username.')
    return
)

passport.serializeUser (user, done) ->
  console.log 'serializeUSER!!!'
  done null, user.id
  return
passport.deserializeUser (id, done) ->
  # query the current user from database
  couch.users.get(id, (err, doc) ->
    if err
      return done new Error('User ' + id + ' does not exist')

    return done null, doc
  )
  return