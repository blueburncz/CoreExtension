# ce_string_format
`script`
```gml
ce_string_format(string[, data])
```

## Description
Replaces all occurences of `${identifier}` in the string with given
 data.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| string | `string` | The string to format. |
| [data] | `array/real` | An array or an id of a map containing the data. If an array is passed, the identifiers must be numbers or variable names of  the calling instance. If a map is passed, the identifiers must be keys of  the map or variable names of the calling instance. Using unknown identifiers  will result in error. Only maps with strings as keys are supported. |

## Returns
`string` The resulting string.

## Example
```
// Prints "Hello, Some!"
username = "Some";
show_debug_message(ce_string_format("Hello, ${username}!"));
// Prints "You have 100 HP."
show_debug_message(ce_string_format("You have ${0} HP.", [100]));
// Prints "Hello, Dude!"
var _data = ds_map_create();
_data[? "username"] = "Dude";
show_debug_message(ce_string_format("Hello, ${username}!", _data));
ds_map_destroy(_data);
```