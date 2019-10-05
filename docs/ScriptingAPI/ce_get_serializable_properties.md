# ce_get_serializable_properties
`script`
```gml
ce_get_serializable_properties(object)
```

## Description
Creates a list of serializable properties of given object, including
 properties inherited from it's parent, parent's parent etc.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| object | `real` | The object index. |

## Returns
`real` The created list of properties.

## Note
 Do not forget to free the list from memory when it's no longer
necessary!