# ce_string_join_array
`script`
```gml
ce_string_join_array(string, array)
```

## Description
Joins values in the array putting the string between each two
 consecutive values.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| string | `string` | The string to put between two consecutive values. |
| array | `array` | An array of values that you want to join. |

## Returns
`string` The resulting string.

## Example
This will show a message saying "Numbers: 1, 2, 3, 4".
```gml
show_message("Numbers: " + ce_string_join_array(", ", [1, 2, 3, 4]));
```