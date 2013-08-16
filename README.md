Funwraps adds additional, custom behavior to your functions.


```javascript
var funwrap = require("funwrap")();

funwrap.add({
  create: function(options) {
    return {
      before: function(data, next) {
        options.validate(data, next);
      }
    };
  }
  test: function(options) {
    return options.validate;
  }
});


var login = funwrap.decorate({
  validate: function(data, next) {
    if(data.username != "craig") return next(new Error("access denied!"));
    next();
  },
  then: function(data, next) {
    //do something
  }
});



login({ name: "craigers" }, function(err) {
  console.log(err.message); // access denied!
});

```

### Features

- Mediator decorator
- Validation decorator
- Ability to prioritize decorators

### Mediator

### Validator
