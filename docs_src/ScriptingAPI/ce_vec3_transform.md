# ce_vec3_transform
`script`
```gml
ce_vec3_transform(v, m)
```

## Description
Transforms a 4D vector `[vX, vY, vZ, 1]` by the matrix `m` and stores
 `[x, y, z]` of the resulting vector to `v`.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v | `array` | The vector to transform. |
| m | `array` | The transform matrix. |