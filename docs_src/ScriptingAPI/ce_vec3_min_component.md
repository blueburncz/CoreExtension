# ce_vec3_min_component
`script`
```gml
ce_vec3_min_component(v)
```

## Description
Gets the smallest component of the vector.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v | `array` | The vector. |

## Returns
`real` The vetor's smallest component.

## Example
Here the `_min` variable would be equal to `1`.
```gml
var _vec = [1, 2, 3];
var _min = ce_vec3_min_component(_vec);
```