# ce_set_prop
`script`
```gml
ce_set_prop(id, prop, value)
```

## Description
Sets value of object's property.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the object. |
| prop | `string/real` | The property identifier. |
| value | `any` | The new property value. |

## Returns
`bool` True if the property value was set or false if the object
 does not have the property.