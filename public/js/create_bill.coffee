addPurchaseLine = ->
  new_line = $('.product-params').first().clone()
  new_line.removeClass('hidden-group')
#  $(':input', new_line).val(null)
#  $('.product-title.dropdown-menu', new_line).remove()
#  $('.add-purchase', new_line).attr('disabled', true)
#  $('.add-purchase .glyphicon', new_line).removeClass('red-text')
#  $('input[name="title"]', new_line).removeClass('warning-field')

  $('.products').append(new_line)
  setPurchaseTypeahead()

setPurchaseTypeahead = ->
  $('.product-title').typeahead({
    source: (query, process) ->
      $.get '/list/products', { query: query }, (data) ->
        process data
    autoSelect: true
  })

setShopTypeahead = ->
  $('.shop-title').typeahead({
    source: (query, process) ->
      $.get '/list/shops', { query: query }, (data) ->
        process data
    autoSelect: true
  })

$ ->
  addPurchaseLine()

  current_date = new Date()
  $('#bill_date').val(current_date.toJSON().slice(0,10))

  $('#create_bill').submit (e)->
    form = this
    console.log form.title
#    e.preventDefault()

    $('.product-params').each(->
      product = {}
      product.title = $('[name="title"]', this)
      console.log product
#      console.log this
    )

    console.log $(form).serialize()
    console.log $(form).serializeArray()

  $(document).on 'change', '.product-title', (e)->
    if $('.product-title').last().val() isnt ''
      addPurchaseLine()



#    return false
  setPurchaseTypeahead()
  setShopTypeahead()

  $(document).on 'change', '.shop-title', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.input-group')
    current = input.typeahead('getActive')

    #    console.log current.name.toLowerCase() is input.val().toLowerCase()
    if current
      # Some item from your model is active!
      if current.name.toLowerCase() is input.val().toLowerCase()
        $('.shop-id').val(current.id)
        parent.find('.add-shop').attr('disabled', true)
        parent.find('.add-shop .glyphicon').removeClass('red-text')
        input.removeClass('warning-field')
        # This means the exact match is found. Use toLowerCase() if you want case insensitive match.
      else
        parent.find('.add-shop').removeAttr('disabled')
        parent.find('.add-shop .glyphicon').addClass('red-text')
        input.addClass('warning-field')
      # This means it is only a partial match, you can either add a new item
      # or take the active if you don't want new items
    else
      parent.find('.add-shop').removeAttr('disabled')
      parent.find('.add-shop .glyphicon').addClass('red-text')
      input.addClass('warning-field')
    # Nothing is active so it is a new value (or maybe empty value)
    return


  $(document).on 'change', '.product-title', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.product-params')
    current = input.typeahead('getActive')

#    console.log current.name.toLowerCase() is input.val().toLowerCase()
    if current
      # Some item from your model is active!
      if current.name.toLowerCase() is input.val().toLowerCase()
        parent.find('.product-id').val(current.id)
        parent.find('.add-purchase').attr('disabled', true)
        parent.find('.add-purchase .glyphicon').removeClass('red-text')
        input.removeClass('warning-field')
        # This means the exact match is found. Use toLowerCase() if you want case insensitive match.
      else
        parent.find('.add-purchase').removeAttr('disabled')
        parent.find('.add-purchase .glyphicon').addClass('red-text')
        input.addClass('warning-field')
        # This means it is only a partial match, you can either add a new item
        # or take the active if you don't want new items
    else
      parent.find('.add-purchase').removeAttr('disabled')
      parent.find('.add-purchase .glyphicon').addClass('red-text')
      input.addClass('warning-field')
      # Nothing is active so it is a new value (or maybe empty value)
    return