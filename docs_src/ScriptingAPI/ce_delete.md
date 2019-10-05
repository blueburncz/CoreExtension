# ce_delete
`script`
```gml
ce_delete(id)
```

## Description
Destroys an instance of a class (object).

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance. |

## Note
 This first calls the object's class destructor, then the
superclass destructor etc.

### See
[ce_class_define_destructor](ce_class_define_destructor.html)