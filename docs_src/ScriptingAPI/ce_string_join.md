# ce_string_join
`script`
```gml
ce_string_join(string, values...)
```

## Description
Joins given values together putting the string between each
 consecutive two.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| string | `string` | The string to put between two consecutive values. |
| values | `any` | Any number of values to be joined. |

## Returns
`string` The resulting string.

## Example
This could show a debug message saying "Player Patrik took 60 damage!".
```gml
show_debug_message(
    ce_string_join(" ", "Player", player.name, "took", _damage, "damage!"));
```