# Getters and setters
Once we have an object created, we can retrieve and change values of its properties using [ce_get_prop](./ce_get_prop.html) and [ce_set_prop](./ce_set_prop.html) respectively.

```gml
var _circle = circle_create(10, 20, 30);
ce_get_prop(_circle, "x"); // => 10
ce_set_prop(_circle, "x", 20); // => true
ce_get_prop(_circle, "x"); // => 20
ce_has_prop(_circle, "foo"); // => false
ce_get_prop(_circle, "foo"); // => undefined
ce_delete(_circle);
```

Important thing to notice is that the functions [ce_get_prop](./ce_get_prop.html) and [ce_set_prop](./ce_set_prop.html) do not end with and error when trying to access nonexistent properties. Instead they return `undefined` and `false` respectively. You can use functions [ce_has_prop](./ce_has_prop.html) and [ce_has_own_prop](./ce_has_own_prop.html) to check whether an object has a specific property.

For information on the [ce_delete](./ce_delete.html) function, see the [Destructor](./ClassDestructor.html) section.