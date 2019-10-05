# ce_gamepad_check
`script`
```gml
ce_gamepad_check(device, button[, state])
```

## Description
Checks whether a gamepad button has given state.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| device | `real` | The gamepad device. |
| button | `real` | The button to check. |
| [state] | `CE_EInputState` | The state to check for. Defaults to `CE_EInputState.Down`. |

## Returns
`bool` True if the button has the expected state.