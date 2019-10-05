# ce_input_scheme_bind
`script`
```gml
ce_input_scheme_bind(scheme, action, type, key[, direction])
```

## Description
Binds the input to the action within the given input scheme.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| scheme | `real` | The id of the scheme. |
| action | `string/real` | The id of the action. |
| type | `CE_EInputType` | The input type. |
| key | `real` | The input key. Use `mb_none` for mouse wheel. |
| [direction] | `CE_EInputDirection` | The input direction. Applicable only for gamepad axis and mouse wheel. |