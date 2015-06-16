setCategoryTypeahead = ->
  $('.product-category').typeahead({
    source: (query, process) ->
      $.get '/list/categories', { query: query }, (data) ->
        process data
    autoSelect: true
  })

$ ->
  setCategoryTypeahead()

  $('.product-category').on 'keyup', (e)->
    $('.product-kind').val(null)

  $('#create_product').off 'submit'
  $('#create_product').on 'submit', (e)->
    form = $(this)
    e.preventDefault()
    globals.sendForm(form, (data)->
      if data.success
        $('.submit-button').hide()
        $('.next-button').show().focus()
    )
    return false

  $('#new_category').on 'show.bs.modal', (e)->
    modal = $(this)
    modal.find('.category-title').val($('.product-category').val())

    $('#create_category').off 'submit'
    $('#create_category').on 'submit', (e)->
      form = $(this)
      e.preventDefault()
      globals.sendForm(form, (data)->
        if data.success
          $('.product-kind').val(data.kind)
          $('.category-id').val(data.id)
      )
      modal.modal('hide')
      $('.add-category').attr('disabled',true)
      return false
    return


  $(document).on 'change', '.product-category', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.input-group')
    current = input.typeahead('getActive')
    #    console.log current.name.toLowerCase() is input.val().toLowerCase()
    if current
      # Some item from your model is active!
      if current.name.toLowerCase() is input.val().toLowerCase()
        $('.category-id').val(current.id)
        $('.product-kind').val(current.kind)
        globals.togglePlusButton(parent, 'disable')
        # This means the exact match is found. Use toLowerCase() if you want case insensitive match.
      else
        globals.togglePlusButton(parent, 'enable')
      # This means it is only a partial match, you can either add a new item
      # or take the active if you don't want new items
    else
      globals.togglePlusButton(parent, 'enable')
    # Nothing is active so it is a new value (or maybe empty value)
    return

  return