# Deserialization
When you have an array or a buffer containing serialized instances, you can deserialize them back using functions [ce_deserialize_from_array](./ce_deserialize_from_array.html) or [ce_deserialize_from_buffer](./ce_deserialize_from_buffer.html) respectively.

Following code is an example showing how the save files created in the [Serialization](./SerializeSerialization.html) section could be loaded using deserialization.

```gml
var _compressed = buffer_load("save.sav");
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