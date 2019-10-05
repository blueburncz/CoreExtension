# ce_array_reduce_right
`script`
```gml
ce_array_reduce_right(array, callback[, initialValue])
```

## Description
Reduces the array from right to left, applying the callback script on
 each value, resulting into a single value.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| array | `array` | The array to reduce. |
| callback | `real` | The reducer script. It takes the accumulator (which is the `initialValue` at start) as the first argument, the current value as  the second argument and optionally the current index as the third argument. |
| [initialValue] | `any` | The initial value. If not specified, the last value in the array is taken. |

## Returns
`any` The result of the reduction.

## Example
```gml
// Here the script scr_reduce_subtract(a, b) returns a - b
var _a = [1, 2, 3, 4];
var _r1 = ce_array_reduce(_a, scr_reduce_subtract); // Results to -8
var _r2 = ce_array_reduce_right(_a, scr_reduce_subtract); // Results to -2
```

### See
[ce_array_reduce](ce_array_reduce.html)