# ce_vec2_create_barycentric
`script`
```gml
ce_vec2_create_barycentric(v1, v2, v3, f, g)
```

## Description
Creates a new vector using barycentric coordinates, following formula
 `v1 + f(v2-v1) + g(v3-v1)`.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v1 | `array` | The first point of triangle. |
| v2 | `array` | The second point of triangle. |
| v3 | `array` | The third point of triangle. |
| f | `real` | The first weighting factor. |
| g | `real` | The second weighting factor. |

## Returns
`array` The created vector.