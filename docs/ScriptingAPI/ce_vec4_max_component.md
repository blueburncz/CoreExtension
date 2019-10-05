# ce_vec4_max_component
`script`
```gml
ce_vec4_max_component(v)
```

## Description
Gets the largest component of the vector.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| v | `array` | The vector. |

## Returns
`real` The vetor's largest component.

## Example
Here the `_max` variable would be equal to `4`.
```gml
var _vec = [1, 2, 3, 4];
var _max = ce_vec4_max_component(_vec);
```