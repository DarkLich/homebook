$ ->
  $('#create_bill').submit (e)->
    form = this
    console.log form.title
    e.preventDefault()

#    if form.title.value == ''
#      alert 'Error: Email cannot be blank!'
#      form.email.focus()
#      return false


    return false
