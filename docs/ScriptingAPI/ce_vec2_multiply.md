# ce_vec2_multiply
`script`
```gml
ce_vec2_multiply(v1, v2)
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
This would make the vector `_v1` equal to `[3, 8]`.
```gml
var _v1 = [1, 2];
var _v2 = [3, 4];
ce_vec2_multiply(_v1, _v2);
```