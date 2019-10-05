# ce_ds_list_insert_unique
`script`
```gml
ce_ds_list_insert_unique(list, value, position)
```

## Description
If the value is not in the list, it is inserted to it at given
 position.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| list | `real` | The id of the list. |
| value | `any` | The value to be added. |
| position | `real` | The index to insert the value at. |

## Returns
`real` The index on which has been the value found or -1.