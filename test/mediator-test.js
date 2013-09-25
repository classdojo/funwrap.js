var funwrap = require("..")(),
expect = require("expect.js"),
type   = require("type-component");


describe("mediator#", function() {

  function timeout(count) {
    return function() {
      var args = Array.prototype.slice.call(arguments, 0),
      next = args.pop();
      setTimeout(function() {
        next.apply(null,[null].concat(args));
      }, count);
    }
  }

  it("can run a pre hooks", function(next) {
    funwrap.mediator.on("pre login", timeout(1), function(options, next) {
      if(options.name != "craig" && options.name != 0) return next(new Error("unauthorized"));
      next(null, options);
    });

    funwrap.mediator.on("login", function(options, next) {
      next(null, "success!");
    });

    var login = funwrap.decorate("login");

    login({ name: "craig" }, function(err, result) {
      expect(result).to.be("success!");
      login({ name: "abba" }, function(err) {
        expect(err.message).to.be("unauthorized");
        next();
      })
    });
  });

  /**
   */

  it("can can a command with options", function(next) {
    funwrap.mediator.on("validate", function(data, next) {
      expect(this.name).to.be("string");
      if(type(data.name) != this.name) {
        return next(new Error("incorrect type"))
      }
      next(null, data);
    });
    funwrap.mediator.on("login", funwrap.decorate({ validate: { name: "string" }}, function(data, next) {
      next(null, "success!!");
    }));

    var login = funwrap.decorate("login");
    login({ name: "craig" }, function(err, result) {
      expect(result).to.be("success!!");
      login({ name: 0 }, function(err, result) {
        expect(err.message).to.be("incorrect type");
        next();
      });
    });
  });


  /**
   */

  it("can reference other commands", function(next) {
    funwrap.mediator.on("login2", "login");
    funwrap.decorate("login2")({ name: "craig" }, function(err, result) {
      expect(result).to.be("success!!");
      next();
    })
  });


  /**
   */

  it("can bind to the request object returned and succeed", function(next) {
    var request = funwrap.mediator.execute("login", { name: "craig" });
    request.bind("result").to(function(){ next() }).now()
  });

  /**
   */

  it("can bind to the request object returned and fail", function(next) {
    var request = funwrap.mediator.execute("login", { name: "baa" });
    request.bind("error").to(function(){ next() }).now()
  });

  /**
   */

  it("can bind to the loading state", function(next) {
    var request = funwrap.mediator.execute("login", { name: "baa" });
    request.bind("loading").to(function(v){ if(!v) next() }).now()
  })

});