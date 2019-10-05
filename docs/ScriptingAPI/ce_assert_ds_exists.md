# ce_assert_ds_exists
`script`
```gml
ce_assert_ds_exists(id, type, msg)
```

## Description
Checks if the data structure of given id and type exists. If it
 does not, then aborts the game, showing the error message.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the ds. |
| type | `real` | The ds type (`ds_type_map`, `ds_type_list`, ...). |
| msg | `string` | The error message. |

## Example
```gml
var _map = ds_map_create();
ce_assert_ds_exists(_map, ds_type_map,
    "This should pass, since we just created it.");
ds_map_destroy(_map);
ce_assert_ds_exists(_map, ds_type_map,
"This will abort the game just as expected.");
```