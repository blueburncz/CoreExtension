# ce_vec4_maximize
`script`
```gml
ce_vec4_maximize(v1, v2)
```

## Description
Gets a vector that is made up of the largest components of the
 vectors `v1`, `v2` and stores it into `v1`.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v1 | `array` | The first vector. |
| v2 | `array` | The second vector. |

## Example
This would make the vector `_v1` equal to `[2, 4, 6, 8]`.
```gml
var _v1 = [1, 4, 5, 8];
var _v2 = [2, 3, 6, 7];
ce_vec4_maximize(_v1, _v2);
```