var funwrap = require("..")(),
expect = require("expect.js");


describe("mediator#", function() {

  it("can run a pre hooks", function(next) {
    funwrap.mediator.on("pre login", function(options, next) {
      if(options.name != "craig") return next(new Error("unauthorized"));
      next();
    });

    funwrap.mediator.on("login", function(options, next) {

    });

    
  });
});