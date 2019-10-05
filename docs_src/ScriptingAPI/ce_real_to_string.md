# ce_real_to_string
`script`
```gml
ce_real_to_string(real)
```

## Description
Converts a real value to a string without generating trailing zeros
 after a decimal point.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| real | `real` | The real value to convert to a string. |

## Returns
`string` The resulting string.

## Example
```gml
ce_real_to_string(16); // => 16
ce_real_to_string(16.870); // => 16.87
```