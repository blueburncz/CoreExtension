# Casting and type checks
If class *A* inherits from class *B*, it is possible to cast objects of class *A* to the type of class *B* using function [ce_cast](./ce_cast.html). When you do so, you lose all the additional information that class *A* provides, but you can work with the object as if it was created from class *B*. Casting is mainly used to access properties hidden through shadowing (see the [Inheritance and shadowing](./ClassInheritanceAndShadowing.html) section).

```gml
var _circle = circle_create(10, 10, 100);
ce_call(_circle, "getArea"); // => 31415.92
var _shape = ce_cast(_circle, shape_class);
ce_call(_shape, "getArea"); // => undefined
// ce_cast(_circle, some_other_class); // Would end with an error
```

To check whether an object is an instance of some class or if it inherits from it, use the function [ce_is_instance](./ce_is_instance.html). You can also retrieve the type of the object or its superclass type using [ce_class_of](./ce_class_of.html) and [ce_superclass_of](./ce_superclass_of.html) respectively.

```gml
ce_class_of(_circle); // => circle_class
ce_superclass_of(_circle); // => shape_class
ce_is_instance(_circle, circle_class); // => true
ce_is_instance(_circle, shape_class); // => true
ce_is_instance(_circle, some_other_class); // => false
```

Important thing to know is that this also works for deeper inheritance chains. If class *A* inherits from *B* which inherits from *C*, it is possible to cast objects of *A* to type of *C*, `ce_is_instance(ce_make_instance(A), C)` would return `true` etc.