# Serialization
When you have defined the serializable properties, you can serialize instances into arrays or buffers using [ce_serialize_to_array](./ce_serialize_to_array.html) or [ce_serialize_to_buffer](./ce_serialize_to_buffer.html) respectively. Both these functions take an optional argument `props`, which is the list of serializable properties of given instance. If it is not specified, it is build automatically using [ce_get_serializable_properties](./ce_get_serializable_properties.html). This can become slow for larger number of instances, so in such case it is better to build the list beforehand, serialize all instances of given object and then destroy the list.

Following is an example code showing how a simple save system could be created using serialization.

```gml
var _buffer = buffer_create(1, buffer_grow, 1);
buffer_seek(_buffer, buffer_seek_start, 0);
// Write number of all instances (player + enemies).
ce_buffer_write(_buffer, buffer_u32, 1 + instance_number(OEnemy));
// The player is only one, so this will be fast.
ce_serialize_to_buffer(OPlayer, _buffer, _props);
// There is a lot of enemies, so it's better to create the property list
// beforehand.
var _props = ce_get_serializable_properties(OEnemy);
with (OEnemy)
{
    ce_serialize_to_buffer(id, _buffer, _props);
}
ds_list_destroy(_props);
var _compressed = buffer_compress(_buffer);
buffer_delete(_buffer);
buffer_save(_compressed, "save.sav");
buffer_delete(_compressed);
```