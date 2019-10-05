# ce_input_to_string
`script`
```gml
ce_input_to_string(scheme, action[, mode])
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| scheme | `real` | The id of the input scheme. |
| action | `string/real` | The id for the action. |
| [mode] | `real` | Use 0 for all keys, 1 for mouse + keyboard only or 2 for gamepad controls only. Defaults to 0. |

## Returns
`string` A string containing controls that trigger the action.