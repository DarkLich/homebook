addPurchaseLine = ->
  new_line = $('.product-params').first().clone()
  new_line.removeClass('hidden-group')

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

setCategoryTypeahead = ->
  $('.product-category').typeahead({
    source: (query, process) ->
      $.get '/list/categories', { query: query }, (data) ->
        process data
    autoSelect: true
  })

$ ->
  addPurchaseLine()

  current_date = new Date()
  $('#bill_date').val(current_date.toJSON().slice(0,10))

  $(document).off 'click', '.add-product'
  $(document).on 'click', '.add-product', (e)->
    parent = $(e.currentTarget).closest('.product-params')

    modal = $('#new_product')
    modal.modal('show')
    modal.find('input[name="title"]').val(parent.find('.product-title').val())

    $('#create_product').off 'submit'
    $('#create_product').on 'submit', (e)->
      form = $(this)
      e.preventDefault()
      globals.sendForm(form, (data)->
        if data.success
          parent.find('.product-id').val(data.id)
          $('#new_product').modal('hide')
          form[0].reset()
          parent.find('.add-button').attr('disabled',true)
          parent.find('.add-button .glyphicon').removeClass('red-text')
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
          modal.modal('hide')
          form[0].reset()
          $('.add-button').attr('disabled',true)
          $('.add-button .glyphicon').removeClass('red-text')
      )
      return false
    return

  $('#create_bill').off 'submit'
  $('#create_bill').on 'submit', (e)->
    form = $(this)
    e.preventDefault()
    globals.sendForm(form, (data)->
      if data.success
        $('.submit-button').hide()
        $('.next-button').show().focus()
    )
    return false

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
  setCategoryTypeahead()

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
