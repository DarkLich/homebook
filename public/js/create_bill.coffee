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
#    e.preventDefault()

#    $('.product-params').each(->
#      product = {}
#      product.title = $('[name="title"]', this)
#      console.log product
##      console.log this
#    )

    console.log $(form).serialize()
    console.log $(form).serializeArray()

  $(document).on 'change', '.product-title', (e)->
    if $('.product-title').last().val() isnt ''
      addPurchaseLine()

  # отправка формы по ctrl + enter
  $(document).on 'keyup', (e)->
    if e.which is 13 and e.ctrlKey is true
      $('#create_bill').submit()

#    return false
  setPurchaseTypeahead()
  setShopTypeahead()

  replaceKoma = (val)->
    return val.replace(/,/ , '.')

  convertToNumber = (num)->
    result = parseFloat(num)
    if isNaN(result)
      result = 0
    return result

  calculatePrice = ()->
    total = 0
    $('.product-sum').each (k, el)->
      total+= convertToNumber($(el).val())
    $('.total-price').val(math.round(total,2))

  $(document).on 'keyup', '.product-sum, .product-count', (e)->
    if e.which is 9
      return
    $(e.currentTarget).val(replaceKoma($(e.currentTarget).val()))
    parent = $(e.currentTarget).closest('.product-params')

    sum = convertToNumber( parent.find('.product-sum').val() )
    count = convertToNumber( parent.find('.product-count').val() )
    price_field = parent.find('.product-price').val(math.round(sum/count,3))

    calculatePrice()
    return

  $(document).on 'change', '.shop-title', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.input-group')
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


  $(document).on 'change', '.product-title', (e)->
    input = $(e.currentTarget)
    parent = input.closest('.product-params')
    current = input.typeahead('getActive')

#    console.log current.name.toLowerCase() is input.val().toLowerCase()
    if current
      # Some item from your model is active!
      if current.name.toLowerCase() is input.val().toLowerCase()
        parent.find('.product-id').val(current.id)
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