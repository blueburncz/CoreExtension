# ce_string_join_list
`script`
```gml
ce_string_join_list(string, list)
```

## Description
Joins values in the list putting the string between each two
 consecutive values.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| string | `string` | The string to put between two consecutive values. |
| list | `real` | The id of the list of values that you want to join. |

## Returns
`string` The resulting string.

## Example
This will show a message saying "Numbers: 1, 2, 3, 4".
```gml
var _numbers = ds_list_create();
ds_list_add(_numbers, 1, 2, 3, 4);
show_message("Numbers: " + ce_string_join_list(", ", _numbers));
```