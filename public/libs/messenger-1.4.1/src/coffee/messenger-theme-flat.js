// Generated by CoffeeScript 1.9.1
(function() {
  var $, FlatMessage, spinner_template,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $ = jQuery;

  spinner_template = '<div class="messenger-spinner">\n    <span class="messenger-spinner-side messenger-spinner-side-left">\n        <span class="messenger-spinner-fill"></span>\n    </span>\n    <span class="messenger-spinner-side messenger-spinner-side-right">\n        <span class="messenger-spinner-fill"></span>\n    </span>\n</div>';

  FlatMessage = (function(superClass) {
    extend(FlatMessage, superClass);

    function FlatMessage() {
      return FlatMessage.__super__.constructor.apply(this, arguments);
    }

    FlatMessage.prototype.template = function(opts) {
      var $message;
      $message = FlatMessage.__super__.template.apply(this, arguments);
      $message.append($(spinner_template));
      return $message;
    };

    return FlatMessage;

  })(window.Messenger.Message);

  window.Messenger.themes.flat = {
    Message: FlatMessage
  };

}).call(this);
