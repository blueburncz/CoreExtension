# ce_array_filter
`script`
```gml
ce_array_filter(array, callback)
```

## Description
Creates a new array containing values from the given array for which the
 callback script returns true.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| array | `array` | The array to filter. |
| callback | `real` | The script that returns `true` to keep the value or `false` to discard it. Takes the original value as the first argument and  optionally it's index as the second argument. |

## Example
This code creates a new array `[0, 2, 4]`.
```gml
var _even = ce_array_filter([0, 1, 2, 3, 4], ce_real_is_even);
```