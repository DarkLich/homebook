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
    var calculatePrice, convertToNumber, current_date, replaceKoma;
    addPurchaseLine();
    current_date = new Date();
    $('#bill_date').val(current_date.toJSON().slice(0, 10));
    $('#create_bill').submit(function(e) {
      var form;
      form = this;
      console.log($(form).serialize());
      return console.log($(form).serializeArray());
    });
    $(document).on('change', '.product-title', function(e) {
      if ($('.product-title').last().val() !== '') {
        return addPurchaseLine();
      }
    });
    $(document).on('keyup', function(e) {
      if (e.which === 13 && e.ctrlKey === true) {
        return $('#create_bill').submit();
      }
    });
    setPurchaseTypeahead();
    setShopTypeahead();
    replaceKoma = function(val) {
      return val.replace(/,/, '.');
    };
    convertToNumber = function(num) {
      var result;
      result = parseFloat(num);
      if (isNaN(result)) {
        result = 0;
      }
      return result;
    };
    calculatePrice = function() {
      var total;
      total = 0;
      $('.product-sum').each(function(k, el) {
        return total += convertToNumber($(el).val());
      });
      return $('.total-price').val(math.round(total, 2));
    };
    $(document).on('keyup', '.product-sum, .product-count', function(e) {
      var count, parent, price_field, sum;
      if (e.which === 9) {
        return;
      }
      $(e.currentTarget).val(replaceKoma($(e.currentTarget).val()));
      parent = $(e.currentTarget).closest('.product-params');
      sum = convertToNumber(parent.find('.product-sum').val());
      count = convertToNumber(parent.find('.product-count').val());
      price_field = parent.find('.product-price').val(math.round(sum / count, 3));
      calculatePrice();
    });
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
