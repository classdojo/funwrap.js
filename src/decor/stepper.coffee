type  = require "type-component"
step    = require "../utils/step"

class Stepper

  ###
  ###

  constructor: (@_funwrap) ->

  ###
  ###

  test: (steps) -> 
    type(steps) is "array"

  ###
  ###

  create: (steps) ->
    steps = steps.map (step) => @_funwrap.decorate(step)
    () => step Array.prototype.slice.call(arguments, 0), steps

module.exports = (funwrap) -> new Stepper funwrap