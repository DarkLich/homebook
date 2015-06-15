$ ->
  Messenger.options = {
    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-left',
    theme: 'future'
  }

  socket = io.connect('http://localhost:3001')
  socket.on 'success', (data)->
    console.log data
#      socket.emit 'my other event', my: 'data'
#      return

    Messenger().post
      message: data.message
      type: "success"
    return

  return


