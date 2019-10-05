# ce_vec3_slerp
`script`
```gml
ce_vec3_slerp(v1, v2, s)
```

## Description
Performs a spherical linear interpolation between the vectors `v1`,
 `v2` and stores the result to `v1`.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v1 | `array` | The first vector. Should be normalized! |
| v2 | `array` | The second vector. Should be normalized! |
| s | `real` | The slerping factor. |

## Source
https://keithmaggio.wordpress.com/2011/02/15/math-magician-lerp-slerp-and-nlerp/