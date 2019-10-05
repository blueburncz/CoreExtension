# ce_object_get_base
`script`
```gml
ce_object_get_base(object)
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| object | `real` | The object index. |

## Returns
`real` The index of the base object in the object's ancestors
 hierarchy.

## Example
If object `C` has parent `B` and object `B` has parent `A`, then
`ce_object_get_base(C) would return `A`.