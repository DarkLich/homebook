// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var _, couch;

  _ = require('lodash');

  couch = require('../../models/couch');

  module.exports = function(req, res, next) {
    couch.replicateTo();
    next();
  };

}).call(this);