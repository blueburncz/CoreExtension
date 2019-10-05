# Inheritance and shadowing
The class system allows you to define up to one class to inherit from when creating a new class. To do so, you simply pass the type of the class you want to inherit from to the [ce_class_create](./ce_class_create.html) function.

Following code will create a new class *circle* which will inherit from our *shape* class.

```gml
/// @func circle_class()
/// @desc Defines a *circle* class, which inherits from the *shape* class.
CE_PRAGMA_ONCE;
var _circleClass = ce_class_create(shape_class);
ce_class_define_properties(_circleClass, [
    // The radius of the circle.
    "radius", 0,
]);
```

When class *A* inherits from class *B*, we call *B* as the *superclass* of class *A*. All classes automatically inherit properties and their values from their superclass, the superclass of the superclass etc.

Sometimes it can be handy to redefine a property with a different default value. In our case, we would like to redefine the *getArea* property with a script which will return the area of the circle. To do so, we just add it to the array of properties.

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
]);

/// @func circle_get_area(id)
/// @param {real} id The id of the circle object.
/// @return {real} The area of the circle object.
return pi * sqr(ce_get_prop(argument[0], "radius"));
```

Important thing to know is that the *circle* class now has two properties *getArea*. One inherited from the *shape* class and one which we just defined. The last definition of a property always "hides" the inherited ones. This is called *shadowing*. If we had an instance of the *circle* class and we wanted to retrieve the value of the *getArea* property (more on that in the [Getters and setters](./ClassGettersAndSetters.html) section), we would get the index of the `circle_get_area` script. In our case this is wanted, but sometimes you may need to know the inherited value. It is possible to retrieve values of shadowed properties through *casting*, which is covered in the [Casting and type checks](./ClassCastingAndTypeChecks.html) section.