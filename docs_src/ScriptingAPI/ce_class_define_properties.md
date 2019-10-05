# ce_class_define_properties
`script`
```gml
ce_class_define_properties(id, propValueArray)
```

## Description
Defines multiple properties of a class. When an instance of a class
 (object) is created, the class properties are copied over to it. That means
 if a class contains for example a grid data structure, its id will be copied
 to all instances of the class, rather than each instance having its own grid
 data structure!

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the class descriptor. |
| propValueArray | `array` | An array containing property names at odd indices and their default values at even indices. |

### See
[ce_class_define_property](ce_class_define_property.html)