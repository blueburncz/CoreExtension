# ce_array_swap
`script`
```gml
ce_array_swap(array, i, j)
```

## Description
Swaps values at given indices in the array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| array | `array` | The array to swap values within. |
| i | `real` | The first index. |
| j | `real` | The second index. |

## Example
```gml
var _array = [1, 2, 3];
ce_array_swap(_array, 0, 2); // Swaps 1 and 3, making the array [3, 2, 1].
```