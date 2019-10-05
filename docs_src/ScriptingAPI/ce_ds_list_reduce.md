# ce_ds_list_reduce
`script`
```gml
ce_ds_list_reduce(list, callback[, initialValue])
```

## Description
Reduces the list from left to right, applying the callback script on
 each value, resulting into a single value.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| list | `real` | The id of the list. |
| callback | `real` | The reducer script. It takes the accumulator (which is the `initialValue` at start) as the first argument, the current value as  the second argument and optionally the current index as the third argument. |
| [initialValue] | `any` | The initial value. If not specified, the first value in the list is taken. |

## Returns
`any` The result of the reduction.

## Example
```gml
// Here the script scr_reduce_add(a, b) returns a + b
var _l = ds_list_create();
ds_list_add(_l, 1, 2, 3, 4);
var _r1 = ce_ds_list_reduce(_l, scr_reduce_add); // Results to 10
var _r2 = ce_ds_list_reduce(_l, scr_reduce_add, 5); // Results to 15
```

### See
[ce_ds_list_reduce_right](ce_ds_list_reduce_right.html)