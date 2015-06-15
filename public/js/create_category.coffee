setCategoryTypeahead = ->
  $('.category-title').typeahead({
    source: (query, process) ->
      $.get '/list/categories', { query: query }, (data) ->
        process data
    autoSelect: true
  })

$ ->
  setCategoryTypeahead()

  $(document).on 'change', '.category-title', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.form-group')
    current = input.typeahead('getActive')

    #    console.log current.name.toLowerCase() is input.val().toLowerCase()
    if current
      # Some item from your model is active!
      if current.name.toLowerCase() is input.val().toLowerCase()
        $('.shop-id').val(current.id)
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