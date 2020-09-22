# Defining serializable properties
By default any serialized instance contains its object name, x and y position and its layer name, because these are required for deserialization. If you want to serialize any additional properties, you can do so using [ce_add_serializable_property](./ce_add_serializable_property.html). Using this function you can define serializable properties of a specific object and all objects which inherit from it, or for every object using the `all` keyword.

```gml
/// @func serialize_config()
gml_pragma("global", "serialize_config();");
// Serializable properties common for all objects
ce_add_serializable_property(all, "sprite_index", buffer_u32);

// Serialize "name" and "hp" for all objects that inherit from OCharacter
ce_add_serializable_property(OCharacter, "name", buffer_string);
ce_add_serializable_property(OCharacter, "hp", buffer_u32);
```

Definition of serializable properties should be done only once per game! A good place to do so could be an initialization room or using `gml_pragma("global")` as in the example above.