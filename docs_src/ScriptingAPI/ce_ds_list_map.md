# ce_ds_list_map
`script`
```gml
ce_ds_list_map(list, callback)
```

## Description
Creates a new list containing the results of calling the script on
 every value in the given list.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| list | `real` | The id of the list. |
| callback | `real` | The script that produces a value of the new list, taking the original value as the first argument and optionally it's index  as the second argument. |