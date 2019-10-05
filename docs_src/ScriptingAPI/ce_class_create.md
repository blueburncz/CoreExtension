# ce_class_create
`script`
```gml
ce_class_create([base[, final]])
```

## Description
Creates a new class descriptor.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| [base] | `real` | The index of the base class definition script. Use `noone` (default) for no base class. |
| [final] | `bool` | True to mark the class as final. Final classes cannot be inherited. Defaults to `false`. |

## Returns
`real` The id of the created class descriptor.

## Example
Following code shows two class definition scripts, one defines a class
*point* which has properties *x* and *y*, other defines a class *circle*
which inherits from the *point* class and has an additional property
*radius*.
```gml
// point_class()
CE_PRAGMA_ONCE;
var _point = ce_class_create();
ce_class_define_properties(_point, [
    "x", 0,
    "y", 0,
]);
// circle_class()
CE_PRAGMA_ONCE;
var _circle = ce_class_create(point_class);
ce_class_define_property(_circle, "radius", 0);
```

## Note
 This script must be called only from class definition scripts in
combination with [CE_PRAGMA_ONCE](./CE_PRAGMA_ONCE.html)!