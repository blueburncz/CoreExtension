# ce_get_prop
`script`
```gml
ce_get_prop(id, prop)
```

## Description
Retrieves a value of object's property.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the object. |
| prop | `string/real` | The property identifier. |

## Returns
`any` The property value or `undefined` if the object does not have
 the property.

### See
[ce_has_prop](ce_has_prop.html), [ce_has_own_prop](ce_has_own_prop.html)