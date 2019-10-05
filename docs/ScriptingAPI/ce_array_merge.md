# ce_array_merge
`script`
```gml
ce_array_merge(a1, a2)
```

## Description
Merges two arrays into a new one, appending values from the second
 array to the end of the first array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| a1 | `array` | The id of the first list. |
| a2 | `array` | The id of the second list. |

## Returns
`array` The created array.

## Example
The array `_a3` will contain values values `1, 2, 3, 3, 4, 5`.
```gml
var _a1 = [1, 2, 3];
var _a2 = [3, 4, 5];
var _a3 = ce_array_merge(_a1, _a2);
```