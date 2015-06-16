// Generated by CoffeeScript 1.9.1
(function() {
  var addPurchaseLine, setCategoryTypeahead, setPurchaseTypeahead, setShopTypeahead;

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

  setCategoryTypeahead = function() {
    return $('.product-category').typeahead({
      source: function(query, process) {
        return $.get('/list/categories', {
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
    $(document).off('click', '.add-product');
    $(document).on('click', '.add-product', function(e) {
      var modal, parent;
      parent = $(e.currentTarget).closest('.product-params');
      modal = $('#new_product');
      modal.modal('show');
      modal.find('input[name="title"]').val(parent.find('.product-title').val());
      $('#create_product').off('submit');
      return $('#create_product').on('submit', function(e) {
        var form;
        form = $(this);
        e.preventDefault();
        globals.sendForm(form, function(data) {
          if (data.success) {
            parent.find('.product-id').val(data.id);
            $('#new_product').modal('hide');
            form[0].reset();
            parent.find('.add-button').attr('disabled', true);
            return parent.find('.add-button .glyphicon').removeClass('red-text');
          }
        });
        return false;
      });
    });
    $('#new_category').on('show.bs.modal', function(e) {
      var modal;
      modal = $(this);
      modal.find('.category-title').val($('.product-category').val());
      $('#create_category').off('submit');
      $('#create_category').on('submit', function(e) {
        var form;
        form = $(this);
        e.preventDefault();
        globals.sendForm(form, function(data) {
          if (data.success) {
            $('.product-kind').val(data.kind);
            $('.category-id').val(data.id);
            modal.modal('hide');
            form[0].reset();
            modal.find('.add-button').attr('disabled', true);
            return modal.find('.add-button .glyphicon').removeClass('red-text');
          }
        });
        return false;
      });
    });
    $('#create_bill').off('submit');
    $('#create_bill').on('submit', function(e) {
      var form;
      form = $(this);
      e.preventDefault();
      globals.sendForm(form, function(data) {
        if (data.success) {
          $('.submit-button').hide();
          return $('.next-button').show().focus();
        }
      });
      return false;
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
    setCategoryTypeahead();
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
          globals.togglePlusButton(parent, 'disable');
        } else {
          globals.togglePlusButton(parent, 'enable');
        }
      } else {
        globals.togglePlusButton(parent, 'enable');
      }
    });
    $(document).on('change', '.product-title', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.product-params');
      current = input.typeahead('getActive');
      if (current) {
        if (current.name.toLowerCase() === input.val().toLowerCase()) {
          parent.find('.product-id').val(current.id);
          globals.togglePlusButton(parent, 'disable');
        } else {
          globals.togglePlusButton(parent, 'enable');
        }
      } else {
        globals.togglePlusButton(parent, 'enable');
      }
    });
    return $(document).on('change', '.product-category', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.input-group');
      current = input.typeahead('getActive');
      if (current) {
        if (current.name.toLowerCase() === input.val().toLowerCase()) {
          $('.category-id').val(current.id);
          $('.product-kind').val(current.kind);
          globals.togglePlusButton(parent, 'disable');
        } else {
          globals.togglePlusButton(parent, 'enable');
        }
      } else {
        globals.togglePlusButton(parent, 'enable');
      }
    });
  });

}).call(this);
