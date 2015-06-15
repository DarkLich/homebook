// Generated by CoffeeScript 1.9.1
(function() {
  var app, io;

  app = require('../app');

  io = require('socket.io')();

  module.exports.init = function(server) {
    console.log('init io');
    io.attach(server);
    io.on('connection', function(socket) {
      console.log('io connection');
    });
  };

  module.exports.show = function(text, type) {
    type = !type ? 'success' : type;
    setTimeout(function() {
      return io.sockets.emit(type, {
        message: text
      });
    }, 3000);
  };

}).call(this);
