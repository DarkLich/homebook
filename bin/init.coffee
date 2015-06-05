express = require('express')
users_db = require('../models/users_db')

app = express()

console.log 'name_______'

#couch.init()
passport = require('passport')
LocalStrategy = require('passport-local').Strategy
passport.use new LocalStrategy({
    usernameField: 'email'
    passwordField: 'password'
  }, (email, password, done) ->
    console.log 'PASSSPORT'
    console.log email
    console.log password
    users_db.users.get email, (err, doc) ->
      console.log '!doc!'
      console.log doc
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
  users_db.users.get(id, (err, doc) ->
    if err
      return done new Error('User ' + id + ' does not exist')

    return done null, doc
  )
  return
