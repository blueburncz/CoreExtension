# Property calls and super
If an object has a property which contains a scripts, it is possible to execute the script with the id of the object as a parameter using function [ce_call](./ce_call.html).

```gml
var _circle = circle_create(10, 10, 100);
ce_call(_circle, "getArea"); // => 31415.92
```

Optionally it is possible to pass additional data to the script as the second argument. We could for example define a new method for our *circle* which would measure distance between borders of two circles:

```gml
/// @func circle_class()
/// @desc Defines a *circle* class, which inherits from the *shape* class.
CE_PRAGMA_ONCE;
var _circleClass = ce_class_create(shape_class);
ce_class_define_properties(_circleClass, [
    // The radius of the circle.
    "radius", 0,
    // Returns the area of the shape.
    "getArea", circle_get_area,
    // Returns distance from another circle.
    "getDistance", circle_get_distance,
]);

/// @func circle_get_distance(id, circle)
/// @param {real} id The id of the circle object.
/// @param {real} circle The id of the circle object to measure distance to.
/// @return {real} Distance between border of the two circles.
var _c1 = argument[0];
var _c2 = argument[1];
var _distanceToCenter = point_distance(
    get_prop(_c1, "x"), get_prop(_c1, "y"),
    get_prop(_c2, "x"), get_prop(_c2, "y"));
var _sumOfRadii = (ce_get_prop(_c1, "radius") + ce_get_prop(_c2, "radius"));
return (_distanceToCenter - _sumOfRadii);

/// @desc Test
var _circle1 = circle_create(0, 0, 10);
var _circle2 = circle_create(100, 0, 10);
ce_call(_circle1, "getDistance", _circle2); // => 80
```

If a definition of a class overrides a method of its superclass (see the [Inheritance and shadowing](./ClassInheritanceAndShadowing.html) section), it is possible to call the overridden method using [ce_super](./ce_super.html). When using this function, you are effectively asking the class system to cast the object to its superclass type (see the [Casting and type checks](./ClassCastingAndTypeChecks.html) section) and then execute the [ce_call](./ce_call.html) function with the casted object as parameter. This is especially handy for the factory scripts for creating new instances, where you call some initialization method, which can then call the initialization script of its superclass and so on.