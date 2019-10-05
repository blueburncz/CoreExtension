# ce_string_compare
`script`
```gml
ce_string_compare(s1, s2)
```

## Description
Compares the first string to the second string.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| s1 | `string` | The first string. |
| s2 | `string` | The seconds string. |

## Returns
`CE_ECompare` `CE_ECompare.Equal` when the strings are equal or
 `CE_ECompare.Less` / `CE_ECompare.Greater` when the first one goes
 before / after the second one.

## Example
 Sorting an array of strings using a bubble sort algorithm and this
function for string comparison.
```gml
var _names = ["John", "Adam", "David"];
var _size = array_length_1d(_names);
for (var i = 0; i < _size - 1; ++i)
{
    for (var j = 0; j < _size - i - 1; ++j)
    {
        if (ce_string_compare(_names[j], _names[j + 1]) == CE_ECompare.Greater)
        {
            ce_array_swap(_names, j, j + 1);
        }
    }
}
// The array is now equal to ["Adam", "David", "John"].
```