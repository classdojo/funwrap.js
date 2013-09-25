Funwraps adds additional, custom behavior to your functions.


### Mediator example 

```javascript
var funwrap = require("funwrap")(),
mediator = funwrap.mediator();
funwrap.use(mediator);

mediator.on("validateLogin", function(options, next) {
    if(!options.name) return next(new Error("not enough info!"));
    next();
});
mediator.on("pre login", "validateLogin");
mediator.on("login", function(options, next) {
  //do stuff!
});


var login = funwrap.decorate("login");

login({ name: "craigers" }, function(err) {
  console.log(err.message); // access denied!
});

```

### Memoizer example

```javascript
var funwrap = require("funwrap")(),
mediator = funwrap.mediator();

funwrap.use(mediator);
mediator.on("getUser", funwrap.decorate(funwrap.memoize, function(options, next) {
  
}));

var getUser = funwrap.decorate("getUser");

getUser({ name: "craig" }, function(err, data) {

    //cache hit.
    getUser({ name: "craig" }, function(err, data) {
    
    });
});
```



### Features

- Mediator decorator
- Validation decorator
- Ability to prioritize decorators
- 

### Mediator

### Finite State Machine

### Validator

Validates data passed in the function

### Memoizer

Memoizes the arguments passed to a function.
