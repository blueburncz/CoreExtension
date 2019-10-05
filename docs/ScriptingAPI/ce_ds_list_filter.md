# ce_ds_list_filter
`script`
```gml
ce_ds_list_filter(list, callback)
```

## Description
Creates a new list containing values from the given list for which the
 callback script returns true.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| list | `real` | The id of the list. |
| callback | `real` | The script that returns `true` to keep the value or `false` to discard it. Takes the original value as the first argument and  optionally it's index as the second argument. |