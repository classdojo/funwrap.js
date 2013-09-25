Funwraps adds additional, custom behavior to your functions.


### Mediator example 

```javascript
var funwrap = require("funwrap")(),
mediator = funwrap.mediator();
funwrap.use(mediator);

mediator.on("validate", function(options, next) {
    for(var name in this.fields) {
      var type = this.fields[name];
      if(typeof options[name] != type) {
        return next(new Error("incorrect type"));
      }
    }
    next();
});
mediator.on("pre login", { 
  validate: {
    fields: {
      name: "string"
    }
  }
});
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
mediator.on("saveProfile", funwrap.decorate(funwrap.memoize, function(options, next) {
  
}));
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
