comerr  = require "comerr"
type    = require "type-component"
step    = require "../utils/step"
bindable = require "bindable"
bindableCall = require "bindable-call"

class Mediator

  ###
  ###

  constructor: (@_funwrap) ->
    @_listeners = {}

  ###
  ###

  on: (command, callbacks...) ->

    commandInfo = command.split(" ")
    name        = commandInfo.pop()
    method      = commandInfo.shift()


    callback = @_funwrap.decorate(callbacks...)

    unless listener = @_listeners[name]
      listener = @_listeners[name] = { pre: [], post: [] }


    if method is "pre"
      listener.pre.push callback
    else if method is "post"
      listener.post.push callback
    else
      listener.callback = callback

  ###
  ###

  execute: (command, context, options, next) ->

    args = Array.prototype.slice.call(arguments, 0)

    command   = args.shift()
    context   = if args.length is 3 then args.shift() else {}
    next      = if args.length is 2 then args.pop() else () ->

    context.loading = true

    request = bindableCall context, (next) =>

      args.push next

      if listener = @_listeners[command]
        callbacks = listener.pre.concat(listener.callback).concat(listener.post)
        step.call request, args, callbacks
      else
        next comerr.notFound("command '#{command}' not found.")

    request.bind("response").once().to (response) ->
      next response.error, response.data

    request

  ###
  ###

  test: (command) -> /object|string/.test type(command)

  ###
  ###

  create: (command) ->
    if (t = type(command)) is "string"
      return (args...) => @execute [command, @].concat(args)...
    else

      commands = command
      fns      = []
      self     = @

      for command of commands then do (command) ->
        context = commands[command]
        fns.push (args...) =>
          self.execute [command, context].concat(args)...

      return (args...) =>
        step args, fns, args.concat().pop()






module.exports = (funwrap) -> new Mediator funwrap