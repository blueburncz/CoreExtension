# ce_ds_map_extend_from_array
`script`
```gml
ce_ds_map_extend_from_array(map, keyValueArray)
```

## Description
Extends a map by key-value pairs stored in an array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| map | `real` | The id of the map. |
| keyValueArray | `array[key, value, ...]` | The array that contains keys at odd indices and values at even indices. |

## Returns
`real` The id of the map.