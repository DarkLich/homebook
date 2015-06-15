// Generated by CoffeeScript 1.9.1
(function() {
  var setCategoryTypeahead;

  setCategoryTypeahead = function() {
    return $('.category-title').typeahead({
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
    return $(document).on('change', '.category-title', function(e) {
      var current, input, parent;
      input = $(e.currentTarget);
      parent = input.closest('.form-group');
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
  });

}).call(this);
