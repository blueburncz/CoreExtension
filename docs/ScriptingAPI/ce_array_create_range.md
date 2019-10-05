# ce_array_create_range
`script`
```gml
ce_array_create_range(from, to)
```

## Description
Creates a new array with values in range <from, to>.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| from | `int` | The starting value. Must be less or equal to argument to. |
| to | `int` | The ending value. Must be greater or equal to argument from. |

## Returns
`array` The created array.

## Example
This will create an array `[2, 3, 4, 5, 6]`.
```gml
var _arr = ce_array_create_range(2, 6);
```