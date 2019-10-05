# ce_serialize_to_buffer
`script`
```gml
ce_serialize_to_buffer(id, buffer[, props])
```

## Description
Serializes an instance to a buffer.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance to be serialized. |
| buffer | `real` | The id of the buffer to serialize instance to. |
| [props] | `real` | An id of a list containing object properties to serialize. If not provided, it will be built automatically using  `ce_get_serializable_properties`. When serializing a large number  of instances of the same object in a row, the script can be much  faster with the list provided! |

## Returns
`array` The created array containing the serialized instance.

## Example
Following code serializes instances of objects `OPlayer` and `OEnemy`
into a buffer, which is then compressed and saved into a file "save1.sav".
```gml
var _buffer = buffer_create(1, buffer_grow, 1);
buffer_seek(_buffer, buffer_seek_start, 0);
// Write number of all instances.
ce_buffer_write(_buffer, buffer_u32, 1 + instance_number(_enemies));
// Player is only one, so this will be fast.
ce_serialize_to_buffer(OPlayer, _buffer, _props);
// There is a lot of enemies, so it's better to create the property
// list beforehand.
var _props = ce_get_serializable_properties(OEnemy);
with (OEnemy)
{
    ce_serialize_to_buffer(id, _buffer, _props);
}
ds_list_destroy(_props);
var _compressed = buffer_compress(_buffer);
buffer_delete(_buffer);
buffer_save(_compressed, "save1.sav");
buffer_delete(_compressed);
```

## Note
 The instance is serialized at the current write position of the buffer,
meaning that you can serialize multiple instances in a sequence.

### See
[ce_get_serializable_properties](ce_get_serializable_properties.html), [ce_deserialize_from_buffer](ce_deserialize_from_buffer.html)