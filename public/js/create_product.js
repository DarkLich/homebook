// Generated by CoffeeScript 1.9.1
(function() {
  var setCategoryTypeahead;

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
    setCategoryTypeahead();
    $(document).on('change', '.product-category', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.input-group');
      current = input.typeahead('getActive');
      if (current) {
        if (current.name.toLowerCase() === input.val().toLowerCase()) {
          $('.category-id').val(current.id);
          globals.togglePlusButton(parent, 'disable');
        } else {
          globals.togglePlusButton(parent, 'enable');
        }
      } else {
        globals.togglePlusButton(parent, 'enable');
      }
    });
    return $('#new_category').on('show.bs.modal', function(e) {
      var modal;
      modal = $(this);
      modal.find('.category-title').val($('.product-category').val());
      $('#create_category').off('submit');
      $('#create_category').on('submit', function(e) {
        var form;
        form = $(this);
        e.preventDefault();
        globals.sendForm(form);
        modal.modal('hide');
        $('.add-category').attr('disabled', true);
        return false;
      });
    });
  });

}).call(this);
