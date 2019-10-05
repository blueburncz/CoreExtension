# ce_serialize_to_array
`script`
```gml
ce_serialize_to_array(id[, props])
```

## Description
Serializes an instance to an array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance to be serialized. |
| [props] | `real` | An id of a list containing object properties to serialize. If not provided, it will be built automatically using  `ce_get_serializable_properties`. When serializing a large number  of instances of the same object in a row, the script can be much  faster with the list provided! |

## Returns
`array` The created array containing the serialized instance.

## Example
```gml
// Player is only one, so this will be fast.
ce_serialize_to_array(OPlayer, _props);
// There is a lot of enemies, so it's better to create the property
// list beforehand.
var _props = ce_get_serializable_properties(OEnemy);
with (OEnemy)
{
    ce_serialize_to_array(id, _props);
}
ds_list_destroy(_props);
```

### See
[ce_get_serializable_properties](ce_get_serializable_properties.html), [ce_deserialize_from_array](ce_deserialize_from_array.html)