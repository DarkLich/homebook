app = require('../app')
io = require('socket.io')()

module.exports.init = (server)->
  console.log 'init io'
  io.attach(server)
  io.on 'connection', (socket) ->
#    io.sockets.emit('news', { hello: 'world' })
    console.log 'io connection'
#    socket.on 'captain', (data) ->
#      console.log data
#      socket.emit 'Hello'
#      return
    return
  return

module.exports.show = (text, type, data) ->
  data = data || null
  type = if !type then 'success' else type
  setTimeout(()->
    io.sockets.emit(type, { message: text, data: data })
  , 3000)
  return


