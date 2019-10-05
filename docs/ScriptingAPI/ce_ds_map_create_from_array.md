# ce_ds_map_create_from_array
`script`
```gml
ce_ds_map_create_from_array(keyValueArray)
```

## Description
Creates a new map, taking keys and values from the array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| keyValueArray | `array` | An array that containing keys at odd indices and values at even indices. |

## Returns
`real` The id of the created map.

## Example
Variables `_p1` and `_p2` hold maps with the exact same key-value pairs.
```gml
var _p1 = ce_ds_map_from_array([
    "first_name", "Some",
    "last_name", "Dude",
    "age", 24,
]);
var _p2 = ds_map_create();
ds_map_add(_p2, "first_name", "Some");
ds_map_add(_p2, "last_name", "Dude");
ds_map_add(_p2, "age", 20);
```