# Creating a class
To create a new class, use the function [ce_class_create](./ce_class_create.html). This function must be used only inside a script, which also has to start with [CE_PRAGMA_ONCE](./CE_PRAGMA_ONCE.html)! The return value of the function is an id of a class descriptor. A class descriptor is a structure that describes what properties the class has, which class it inherits from etc.

We will refer to an index of a script in which you create a class as the *type* of the class. This type is used to make new instances of the class, which we call objects, as well as checking whether an object inherits from a class etc.

Following code defines a new class *shape*, which we will further use as a base class for geometric shapes.

```gml
/// @func shape_class()
/// @desc Defines a *shape* class.
CE_PRAGMA_ONCE;
var _shapeClass = ce_class_create();
```