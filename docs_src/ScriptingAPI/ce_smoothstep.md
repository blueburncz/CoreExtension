# ce_smoothstep
`script`
```gml
ce_smoothstep(e0, e1, x)
```

## Description
Performs smooth Hermite interpolation between 0 and 1 when
 e0 < x < e1.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| e0 | `real` | The lower edge of the Hermite function. |
| e1 | `real` | The upper edge of the Hermite function. |
| x | `real` | The source value for interpolation. |

## Returns
`real` The resulting interpolated value.

## Source
https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/smoothstep.xhtml