$ ->
  $('#register_form').submit (e)->
    form = this

    if form.email.value == ''
      alert 'Error: Email cannot be blank!'
      form.email.focus()
      return false
    re = /^\w+$/
    if !re.test(form.email.value)
      alert 'Error: Email must contain only letters, numbers and underscores!'
      form.email.focus()
      return false
    if form.password.value != '' and form.password.value == form.password_confirm.value
      if form.password.value.length < 6
        alert 'Error: Password must contain at least six characters!'
        form.password.focus()
        return false
      if form.password.value == form.email.value
        alert 'Error: Password must be different from Email!'
        form.password.focus()
        return false
      re = /[0-9]/
      if !re.test(form.password.value)
        alert 'Error: password must contain at least one number (0-9)!'
        form.password.focus()
        return false
      re = /[a-z]/
      if !re.test(form.password.value)
        alert 'Error: password must contain at least one lowercase letter (a-z)!'
        form.password.focus()
        return false
      re = /[A-Z]/
      if !re.test(form.password.value)
        alert 'Error: password must contain at least one uppercase letter (A-Z)!'
        form.password.focus()
        return false
    else
      alert 'Error: Please check that you\'ve entered and confirmed your password!'
      form.password.focus()
      return false
    alert 'You entered a valid password: ' + form.password.value
    true

  return