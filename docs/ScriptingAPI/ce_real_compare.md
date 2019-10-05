# ce_real_compare
`script`
```gml
ce_real_compare(r1, r2)
```

## Description
Compares two numbers.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| r1 | `real` | The first number. |
| r2 | `real` | The second number. |

## Returns
`CE_ECompare` `CE_ECompare.Equal` if the numbers are equal or
 `CE_ECompare.Less` / `CE_ECompare.Greater` if the first number is
 less / greater than the second number.

## Example
Sorting an array of numbers using a bubble sort algorithm and this function
for number comparison.
```gml
var _numbers = [3, 1, 2];
var _size = array_length_1d(_numbers);
for (var i = 0; i < _size - 1; ++i)
{
    for (var j = 0; j < _size - i - 1; ++j)
    {
        if (ce_string_compare(_numbers[j], _numbers[j + 1]) == CE_ECompare.Greater)
        {
            ce_array_swap(_numbers, j, j + 1);
        }
    }
}
// The array is now equal to [1, 2, 3].
```