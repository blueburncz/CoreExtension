# ce_input_scheme_clear_bindings
`script`
```gml
ce_input_scheme_clear_bindings(scheme, action[, mode])
```

## Description
Clears key bindings of the action.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| scheme | `real` | The id of the scheme. |
| [mode] | `real` | Use 0 to clear all, 1 to clear mouse + keyboard or 2 to clear gamepad bindings. Defaults to 0. |
| action | `string/real` | The id of the action. |