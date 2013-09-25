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

  on: (command, listener) ->

    unless listener = @_listeners[command]
      listener = @_listeners[command] = { pre: [], post: [] }

    if /^pre\s/.test(command)
      listener.pre.push command
    else if /^post\s/.test(command)
      listener.post.push command
    else
      listener.callback = listener

  ###
  ###

  execute: (command, options, next) ->

    return comerr.notFound("command '#{command}' not found.") unless listener = @_listeners[command]

    args = Array.prototype.slice.call(arguments, 0)

    command = args.shift()
    callbacks = listener.pre.concat(listener.callback).concat(listener.post)

    step args, callbacks, next

  ###
  ###

  test: (command) -> 
    type(command) is "string"

  ###
  ###

  create: (command) ->
    () =>
      @execute [command].concat arguments




module.exports = () -> new Mediator()