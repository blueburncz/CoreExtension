# ce_input_encode
`script`
```gml
ce_input_encode(device, type, key[, direction])
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| device | `real` | The id of the controller. Use 0 when not applicable. |
| type | `CE_EInputType` | The input type. |
| key | `real` | The input key. Use `mb_none` for mouse wheel. |
| [direction] | `CE_EInputDirection` | The input direction. Applicable only for gamepad axis and mouse wheel. |

## Returns
`real` The input encoded into a single number.

### See
[ce_input_decode_device](ce_input_decode_device.html), [ce_input_decode_direction](ce_input_decode_direction.html), [ce_input_decode_key](ce_input_decode_key.html), [ce_input_decode_type](ce_input_decode_type.html)