# ce_surface_check
`script`
```gml
ce_surface_check(surface, width, height)
```

## Description
Checks whether the surface exists and if it has correct size. Broken
 surfaces are recreated. Surfaces of wrong size are resized.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| surface | `real` | The id of the surface. |
| width | `real` | The desired width of the surface. |
| height | `real` | The desired height of the surface. |

## Returns
`real` The surface id.