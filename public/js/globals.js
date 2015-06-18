// Generated by CoffeeScript 1.9.1
(function() {
  window.globals = {};

  globals.togglePlusButton = function(parent, state) {
    if (state !== 'disable') {
      state = 'enable';
    }
    if (state === 'enable') {
      parent.find('.add-button').removeAttr('disabled');
      parent.find('.add-button .glyphicon').addClass('red-text');
      parent.find('input').addClass('warning-field');
    } else {
      parent.find('.add-button').attr('disabled', true);
      parent.find('.add-button .glyphicon').removeClass('red-text');
      parent.find('input').removeClass('warning-field');
    }
  };

  globals.sendForm = function(form, cb) {
    $.ajax({
      type: "POST",
      url: form.attr('action'),
      data: form.serialize(),
      success: function(data) {
        if (typeof cb === 'function') {
          return cb(data);
        }
      }
    });
  };

}).call(this);