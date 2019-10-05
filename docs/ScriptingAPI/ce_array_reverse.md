# ce_array_reverse
`script`
```gml
ce_array_reverse(array)
```

## Description
Creates a new array with values from the given array, but in a reverse
 order.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| array | `array` | The array to reverse. |

## Returns
`array` The created array.

## Example
This will create an array `[3, 2, 1]`.
```gml
var _reversed = ce_array_reverse([1, 2, 3]);
```