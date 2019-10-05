# ce_ds_list_swap
`script`
```gml
ce_ds_list_swap(list, i, j)
```

## Description
Swaps values at given indices in the list.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| list | `real` | The id of the list to swap values within. |
| i | `real` | The first index. |
| j | `real` | The second index. |

## Example
```gml
var _list = ds_list_create();
ds_list_add(_list, 1, 2, 3);
ce_ds_list_swap(_list, 0, 2); // Swaps 1 and 3, making the list `3, 2, 1`.
```