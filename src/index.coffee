decor   = require "./decor"
factories = require "factories"

class Funwrap

  ###
  ###

  constructor: () ->
    @_decorators = factories.any()

    # call mediator fn
    @use @mediator = decor.mediator()
    @use decor.fn()
    @use decor.stepper @

  ###
  ###

  decorate: () ->

    steps = Array.prototype.slice.call(arguments, 0)

    if steps.length is 1
      steps = steps[0]

    @_decorators.create steps

  ###
  ###

  use: () -> @_decorators.factories.push arguments...

  

module.exports = () -> new Funwrap()