# ce_per_second
`script`
```gml
ce_per_second(value)
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| value | `real` | The value to convert. |

## Returns
`real` The converted value.

## Example
This will make the calling instance move to the right by 32px per second,
independently on the framerate.
```gml
x += ce_per_second(32);
```