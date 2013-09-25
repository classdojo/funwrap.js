type = require "type-component"

class FnDecor

  ###
  ###

  test: (fn) -> type(fn) is "function"
  create: (fn) -> fn


module.exports = () -> new FnDecor()