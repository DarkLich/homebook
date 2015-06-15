window.globals = {}

globals.togglePlusButton = (parent, state)->
  if state isnt 'disable'
    state = 'enable'

  if state is 'enable'
    parent.find('.add-button').removeAttr('disabled')
    parent.find('.add-button .glyphicon').addClass('red-text')
    parent.find('input').addClass('warning-field')
  else
    parent.find('.add-button').attr('disabled', true)
    parent.find('.add-button .glyphicon').removeClass('red-text')
    parent.find('input').removeClass('warning-field')
  return

globals.sendForm = (form)->
  $.ajax(
    type: "POST"
    url: form.attr('action')
    data: form.serialize()
    success: (data)->
      console.log(data)
  )
  return