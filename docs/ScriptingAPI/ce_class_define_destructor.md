# ce_class_define_destructor
`script`
```gml
ce_class_define_destructor(id, destructor)
```

## Description
Defines a destructor of a class. When an instance of a class is
 destroyed using [ce_delete](./ce_delete.html), its class destructor is
 executed first, then the destructor of its superclass etc.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the class descriptor. |
| destructor | `real` | The index of the destructor script. Destructor scripts must take an id of an instance as the first argument. |

### See
[ce_delete](ce_delete.html)