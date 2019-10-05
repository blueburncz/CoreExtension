# ce_ds_list_merge
`script`
```gml
ce_ds_list_merge(l1, l2)
```

## Description
Merges the lists into a new one, which will contain all values from
 both of them (including duplicates).

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| l1 | `real` | The id of the first list. |
| l2 | `real` | The id of the second list. |

## Returns
`real` The id of the created list.

## Example
This will create a list with values `1, 2, 3, 3, 4, 5`.
```gml
var _l1 = ds_list_create();
ds_list_add(_l1, 1, 2, 3);
var _l2 = ds_list_create();
ds_list_add(_l1, 3, 4, 5);
var _l3 = ce_ds_list_merge(_l1, _l2);
```