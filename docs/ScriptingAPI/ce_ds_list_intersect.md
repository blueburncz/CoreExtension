# ce_ds_list_intersect
`script`
```gml
ce_ds_list_intersect(l1, l2)
```

## Description
Creates a new list with values being the intersection of l1 and l2.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| l1 | `real` | The id of the first list. |
| l2 | `real` | The id of the second list. |

## Returns
`real` The id of the created list.

## Example
This will create a list with values `1, 2, 3, 4, 5`.
```gml
var _l1 = ds_list_create();
ds_list_add(_l1, 1, 2, 3);
var _l2 = ds_list_create();
ds_list_add(_l1, 3, 4, 5);
var _l3 = ce_ds_list_intersect(_l1, _l2);
```