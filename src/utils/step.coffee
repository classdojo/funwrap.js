async   = require "async"
outcome = require "outcome"

module.exports = (args, steps) ->
  
  next = args.pop()

  async.eachSeries steps, ((step, next) =>
    complete = outcome.e(next).s () ->
      args = Array.prototype.slice.call(arguments, 0)
      next()

    step.apply @, args.concat(complete)
  ), outcome.e(next).s () =>
    next.apply @, [undefined].concat(args)