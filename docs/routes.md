### Router Use Case

```javascript
var router = funwrap();

router.mediator.on("redirect", function(options, next) {
  var location = this.location || options.location;
  next();
});

router.mediator.on("pre dashboard", function(next) {
  if(!loggedIn) {
    router.mediator.execute("login");
    next(new Error("not logged in"));
  }
  next();
});

router.mediator.on("states", function(next) {

  for(var state in this.states) {
    models.set("states." + state, this.states[state]);
  } 

  next();
});

router.mediator.on("main", {
  states: {
    main: "app"
  }
});

router.mediator.on("dashboard", "app", { 
  states: {
    content: "dashboard"
  }
});

router.mediator.on("change-avatar", "app", {
  states: {
    content: "changeAvatar"
  }
});

```