# ce_ds_index_find
`script`
```gml
ce_ds_index_find(index, key, value[, comparatorScript, comparison]])
```

## Description
Finds maps in the index which have the given key-value pair.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| index | `real` | The id of the index. |
| key | `any` | The key to search for. |
| value | `real/string` | The value to search for / compare to. |
| [comparatorScript] | `real` | The script to be used for comparing values. |
| [comparison] | `CE_ECompare` | Use to specify whether the value should be less, equal or greater than the `value` argument. Defaults to equal. |

## Returns
`real` An id of a list containing the found maps. Do not forget
 to destroy the list when it's no longer necessary to prevent memory leaks!

## Example
This code creates a database of weapons, searches for all weapons which have
attack greater than 1 and then prints out their names.
```gml
var _weapons = ce_ds_index_create();
var _wKnife = ce_ds_map_create_from_array([
    "name", "Knife",
    "attack", 2
]);
ce_ds_index_add(_weapons, _wKnife);
var _wRustyKnife = ce_ds_map_create_from_array([
    "name", "Rusty Knife",
    "attack", 1
]);
ce_ds_index_add(_weapons, _wRustyKnife);
var _found = ce_ds_index_find(_weapons, "attack", 1, ce_real_compare, CE_ECompare.Greater);
var _size = ds_list_size(_found);
for (var i = 0; i < _size; ++i)
{
    var _item = _found[| i];
    show_debug_message(_item[? "name"]);
}
ds_list_destroy(_found);
```