# Creating instances
To create a new instance of a class (shortly *object*), use the function [ce_make_instance](./ce_make_instance.html). This function takes a class *type* and returns an id of a created object.

The class system does not have anything like constructors which you may know from other programming languages, but the same effect can be achieved using a factory design pattern - we can make scripts which create instances, assign their properties, call some initialization method etc. and then return the instance id.

Following is an example of such script, which creates new instances of our *circle* class.

```gml
/// @func circle_create(x, y, radius)
/// @desc Creates a new *circle* object.
/// @param {real} x The x position of the circle.
/// @param {real} x The y position of the circle.
/// @param {real} radius The radius of the circle.
/// @return {real} The id of the created object.
var _circle = ce_make_instance(circle_class);
ce_set_prop(_circle, "x", argument0);
ce_set_prop(_circle, "y", argument1);
ce_set_prop(_circle, "radius", argument2);
ce_call(_circle, "_init");
return _circle;
```

See sections [Getters and setters](./ClassGettersAndSetters.html) and [Property calls and super](./ClassPropertyCallsAndSuper.html) for more information on [ce_set_prop](./ce_set_prop.html) and [ce_call](./ce_call.html) respectively.