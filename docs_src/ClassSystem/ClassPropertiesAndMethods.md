# Class properties and methods
To define a new property of a class, use the function [ce_class_define_property](./ce_class_define_property.html). The function expects the name of the property and its default value as parameters. When a new instance of a class is created, the default value is copied to it. That means that if you had a property with a default value equal to an id of a list for example, new instances would not have their own list created, but they would all share the same list instead!

Following code adds properties *x*, *y* and *getArea* to the *shape* class.

```gml
/// @func shape_class()
/// @desc Defines a *shape* class.
CE_PRAGMA_ONCE;
var _shapeClass = ce_class_create();
// The position of the shape on the x axis.
ce_class_define_property(_shapeClass, "x", 0);
// The position of the shape on the y axis.
ce_class_define_property(_shapeClass, "y", 0);
// Returns the area of the shape.
ce_class_define_property(_shapeClass, "getArea", undefined);
```

We can tell from the comment above the *getArea* property that it should be a script. If a property of a class contains a script, we will call it a *method*. Current limitation of the class system is that methods can take only up to two arguments, the first one being an id of an instance and the second one some additional data (possibly an array with multiple values if needed). Methods can be executed using the [ce_call](./ce_call.html) function. More on that in the [Property calls and super](./ClassPropertyCallsAndSuper.html) section.

Defining a lot of properties one by one using the previous function can be a tedious process, so there is also a function [ce_class_define_properties](./ce_class_define_properties.html), which allows you to define multiple properties at once. This function takes an array with property names and their values interleaved. We could rewrite the code above using the function like so:

```gml
/// @func shape_class()
/// @desc Defines a *shape* class.
CE_PRAGMA_ONCE;
var _shapeClass = ce_class_create();
ce_class_define_properties(_shapeClass, [
    // The position of the shape on the x axis.
    "x", 0,
    // The position of the shape on the y axis.
    "y", 0,
    // Returns the area of the shape.
    "getArea", undefined,
]);
```