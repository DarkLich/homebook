// Generated by CoffeeScript 1.9.1
(function() {
  var addPurchaseLine, setPurchaseTypeahead, setShopTypeahead;

  addPurchaseLine = function() {
    var new_line;
    new_line = $('.product-params').first().clone();
    new_line.removeClass('hidden-group');
    $('.products').append(new_line);
    return setPurchaseTypeahead();
  };

  setPurchaseTypeahead = function() {
    return $('.product-title').typeahead({
      source: function(query, process) {
        return $.get('/list/products', {
          query: query
        }, function(data) {
          return process(data);
        });
      },
      autoSelect: true
    });
  };

  setShopTypeahead = function() {
    return $('.shop-title').typeahead({
      source: function(query, process) {
        return $.get('/list/shops', {
          query: query
        }, function(data) {
          return process(data);
        });
      },
      autoSelect: true
    });
  };

  $(function() {
    var current_date;
    addPurchaseLine();
    current_date = new Date();
    $('#bill_date').val(current_date.toJSON().slice(0, 10));
    $('#create_bill').submit(function(e) {
      var form;
      form = this;
      console.log(form.title);
      $('.product-params').each(function() {
        var product;
        product = {};
        product.title = $('[name="title"]', this);
        return console.log(product);
      });
      console.log($(form).serialize());
      return console.log($(form).serializeArray());
    });
    $(document).on('change', '.product-title', function(e) {
      if ($('.product-title').last().val() !== '') {
        return addPurchaseLine();
      }
    });
    setPurchaseTypeahead();
    setShopTypeahead();
    $(document).on('change', '.shop-title', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.input-group');
      current = input.typeahead('getActive');
      if (current) {
        if (current.name.toLowerCase() === input.val().toLowerCase()) {
          $('.shop-id').val(current.id);
          parent.find('.add-shop').attr('disabled', true);
          parent.find('.add-shop .glyphicon').removeClass('red-text');
          input.removeClass('warning-field');
        } else {
          parent.find('.add-shop').removeAttr('disabled');
          parent.find('.add-shop .glyphicon').addClass('red-text');
          input.addClass('warning-field');
        }
      } else {
        parent.find('.add-shop').removeAttr('disabled');
        parent.find('.add-shop .glyphicon').addClass('red-text');
        input.addClass('warning-field');
      }
    });
    return $(document).on('change', '.product-title', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.product-params');
      current = input.typeahead('getActive');
      if (current) {
        if (current.name.toLowerCase() === input.val().toLowerCase()) {
          parent.find('.product-id').val(current.id);
          parent.find('.add-purchase').attr('disabled', true);
          parent.find('.add-purchase .glyphicon').removeClass('red-text');
          input.removeClass('warning-field');
        } else {
          parent.find('.add-purchase').removeAttr('disabled');
          parent.find('.add-purchase .glyphicon').addClass('red-text');
          input.addClass('warning-field');
        }
      } else {
        parent.find('.add-purchase').removeAttr('disabled');
        parent.find('.add-purchase .glyphicon').addClass('red-text');
        input.addClass('warning-field');
      }
    });
  });

}).call(this);
