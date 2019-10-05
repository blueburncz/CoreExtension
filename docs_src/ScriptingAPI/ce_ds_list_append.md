# ce_ds_list_append
`script`
```gml
ce_ds_list_append(l1, l2)
```

## Description
Adds all values from the list l2 to the end of the list l1.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| l1 | `real` | The id of the list to add values to. |
| l2 | `real` | The id of the list to read values from. |

## Example
```gml
var _l1 = ds_list_create();
ds_list_add(_l1, 1, 2, 3);
var _l2 = ds_list_create();
ds_list_add(_l1, 3, 4, 5);
// The list _l1 now contains values 1, 2, 3, 3, 4, 5. The _l2 stays
// the same.
```