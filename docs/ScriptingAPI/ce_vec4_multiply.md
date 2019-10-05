# ce_vec4_multiply
`script`
```gml
ce_vec4_multiply(v1, v2)
```

## Description
Multiplies the vectors `v1`, `v2` componentwise and stores the result
 into `v1`.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v1 | `array` | The first vector. |
| v2 | `array` | The second vector. |

## Example
This would make the vector `_v1` equal to `[5, 12, 21, 32]`.
```gml
var _v1 = [1, 2, 3, 4];
var _v2 = [5, 6, 7, 8];
ce_vec4_multiply(_v1, _v2);
```