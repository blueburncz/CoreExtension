# ce_deserialize_from_buffer
`script`
```gml
ce_deserialize_from_buffer(buffer)
```

## Description
Instantiates an object serialized into the buffer.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| buffer | `real` | The id of the buffer to deserialize an instance from. |

## Returns
`real` The id of the created instance.

## Example
Following code loads a buffer from file "save1.sav", decompresses it and
instantiates all contained serialized objects.
```gml
var _compressed = buffer_load("save1.sav");
var _buffer = buffer_decompress(_compressed);
buffer_delete(_compressed);
buffer_seek(_buffer, buffer_seek_start, 0);
var _instanceCount = buffer_read(_buffer, buffer_u32);
repeat (_instanceCount)
{
    ce_deserialize_from_buffer(_buffer);
}
buffer_delete(_buffer);
```

## Note
 The instance is deserialized using data from the current read position
of the buffer, meaning that you can deserialize multiple instances in a sequence.

### See
[ce_serialize_to_buffer](ce_serialize_to_buffer.html)