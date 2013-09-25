var funwrap = require("..")(),
expect = require("expect.js");


describe("simple#", function() {

  /**
   */

  it("can wrap 1 function", function(next) {
    funwrap.decorate(function(message, next) {
      next(null, message + " world");
    })("hello", function(err, message) {
      expect(message).to.be("hello world");
      next();
    })
  });

  /**
   */

  it("can return an error", function(next) {
    funwrap.decorate(function(next) {
      next(new Error("failed!"));
    })(function(err) {
      expect(err.message).to.be("failed!");
      next();
    })
  });

  /**
   */

  it("can manipulate the arguments passed in a chain", function(next) {
    funwrap.decorate(function(next) {
      next(null, "hello");
    }, function(message, next) {
      next(null, message + " world");
    })(function(err, message) {
      expect(message).to.be("hello world");
      next();
    });
  });

  /**
   */

  it("can pass multiple arguments", function(next) {
    funwrap.decorate(function(next) {
      next(null, "hello");
    }, function(message, next) {
      next(null, message, "world");
    })(function(err, message, message2) {
      expect(message).to.be("hello");
      expect(message2).to.be("world");
      next();
    });
  });
});