// Generated by CoffeeScript 1.6.2
(function() {
  var async, outcome;

  async = require("async");

  outcome = require("outcome");

  module.exports = function(args, steps) {
    var next,
      _this = this;

    next = args.pop();
    return async.eachSeries(steps, (function(step, next) {
      var complete;

      complete = outcome.e(next).s(function() {
        args = Array.prototype.slice.call(arguments, 0);
        return next();
      });
      return step.apply(_this, args.concat(complete));
    }), outcome.e(next).s(function() {
      return next.apply(_this, [void 0].concat(args));
    }));
  };

}).call(this);