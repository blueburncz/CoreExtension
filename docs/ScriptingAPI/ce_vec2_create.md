# ce_vec2_create
`script`
```gml
ce_vec2_create(x[, y])
```

## Description
Creates a new vector with given components. If only the first value
 is supplied, then it is used for every component.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| x | `real` | The first vector component. |
| y | `real` | The second vector component. |

## Returns
`array` The created vector.

## Note
 One could also just write `[x, y]`, which would give the same result.