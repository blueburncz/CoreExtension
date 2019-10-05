# ce_is_instance
`script`
```gml
ce_is_instance(id, class)
```

## Description
Checks whether an object is an instance of a class or if it inherits
 from it.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the object. |
| class | `real` | The index of the class definition script. |

## Returns
`bool` True if the instance is an instance of / inherits from the class.

## Example
 If a class *C* inherits from *B* and *B* inherits from *A*, then
`ce_is_instance(ce_make_instance(C), A)` returns `true`.

### See
[ce_class_of](ce_class_of.html), [ce_superclass_of](ce_superclass_of.html)