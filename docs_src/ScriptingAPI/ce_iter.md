# ce_iter
`script`
```gml
ce_iter(struct[, dsType])
```

## Description
Iterates over the data structure. Should be used only as the conditional
 in the `while` clause! Nested iterators are supported.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| struct | `array/real` | The array or the id of the data structure. |
| [type] | `real` | The type of the data structure. Currently `ds_type_list` and `ds_type_map` are supported. This parameter is obligatory when `struct` is  not an array. |

## Returns
`bool` True if the iteration continues.

## Example
Following code iterates through the array, skipping index 1 and breaking
at index 2, so it prints only '0:1' and '2:3' to the console.
```gml
var _arr = [1, 2, 3, 4];
while (ce_iter(_arr))
{
    if (CE_ITER_INDEX == 1)
    {
        CE_ITER_CONTINUE;
    }
    show_debug_message(
        ce_string_format("${0}: ${1}", [CE_ITER_INDEX, CE_ITER_VALUE]));
    if (CE_ITER_INDEX == 2)
    {
        CE_ITER_BREAK;
    }
}
```

## Note
 All structures have to be created first and stored into a variable
before iterating them!