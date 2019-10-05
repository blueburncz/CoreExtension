# ce_add_serializable_property
`script`
```gml
ce_add_serializable_property(object, property, type)
```

## Description
Registers object property for serialization.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| object | `real` | The object index. Use `all` if all object should have this property. |
| property | `string` | The name of the property. |
| type | `real` | The type of the property. Use `buffer_` constants. |

## Example
Registers `sprite_index` as common serializable property of all objects.
```gml
ce_add_serializable_property(all, "sprite_index", buffer_u32);
```