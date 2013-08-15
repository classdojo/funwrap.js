Funwraps adds additional, custom behavior to your functions.


```javascript
var funwrap = require("funwrap")();

funwrap.add({
  map: function(options, data, next) {
    options.validate(data, next);
  },
  test: function(options) {
    return options.validate;
  }
});


var login = funwrap.it({
  validate: function(data, next) {
    if(data.username != "craig") return next(new Error("access denied!"));
    next();
  },
}, function(data, next) {
  
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