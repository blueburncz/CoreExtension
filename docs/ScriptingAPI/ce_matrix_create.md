# ce_matrix_create
`script`
```gml
ce_matrix_create(m00, m01, m02, m03, m10, m11, m12, m13, m20, m21, m22, m23, m30, m31, m32, m33)
```

## Description
Creates a matrix with given components.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| m00..m03 | `real` | The first row of the matrix. |
| m10..m13 | `real` | The second row of the matrix. |
| m20..m23 | `real` | The third row of the matrix. |
| m30..m33 | `real` | The fourth row of the matrix. |

## Returns
`array` The created matrix.