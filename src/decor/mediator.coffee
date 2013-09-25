comerr  = require "comerr"
type    = require "type-component"
step    = require "../utils/step"

class Mediator

  ###
  ###

  constructor: () ->
    @_listeners = {}

  ###
  ###

  on: (command, callback) ->

    commandInfo = command.split(" ")
    name        = commandInfo.pop()
    method      = commandInfo.shift()

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

    return next(comerr.notFound("command '#{command}' not found.")) unless listener = @_listeners[command]

    args = Array.prototype.slice.call(arguments, 0)

    command   = args.shift()
    context   = args.shift()
    callbacks = listener.pre.concat(listener.callback).concat(listener.post)

    step.call context, args, callbacks, next

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
      fns = []
      self = @
      for command of commands then do (command) ->
        context = commands[command]
        fns.push (args...) =>
          self.execute [command, context].concat(args)...

      return (args...) =>
        step args, fns, args.concat().pop()






module.exports = () -> new Mediator()