# ce_vec3_create
`script`
```gml
ce_vec3_create(x[, y, z])
```

## Description
Creates a new vector with given components. If only the first value
 is supplied, then it is used for every component.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| x | `real` | The first vector component. |
| y | `real` | The second vector component. |
| z | `real` | The third vector component. |

## Returns
`array` The created vector.

## Note
 One could also just write `[x, y, z]`, which would give the same
result.