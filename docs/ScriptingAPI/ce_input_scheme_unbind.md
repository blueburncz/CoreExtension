# ce_input_scheme_unbind
`script`
```gml
ce_input_scheme_unbind(scheme, action, type, key[, direction])
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| scheme | `real` | The id of the scheme. |
| action | `string/real` | The id of the action. Use `undefined` to unbind from all actions. |
| type | `CE_EInputType` | The input type. |
| key | `real` | The input key. Use `mb_none` for mouse wheel. |
| [direction] | `CE_EInputDirection` | The input direction. Applicable only for gamepad axis and mouse wheel. |