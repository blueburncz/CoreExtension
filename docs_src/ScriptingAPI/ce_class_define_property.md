# ce_class_define_property
`script`
```gml
ce_class_define_property(id, prop, value)
```

## Description
Defines a property of a class. When an instance of a class (object) is
 created, the class properties are copied over to it. That means if a class
 contains for example a grid data structure, its id will be copied to all
 instances of the class, rather than each instance having its own grid data
 structure!

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the class descriptor. |
| prop | `string/real` | The property identifier. |
| value | `any` | The default value of the property. |

### See
[ce_class_define_properties](ce_class_define_properties.html)