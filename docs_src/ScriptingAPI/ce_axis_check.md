# ce_axis_check
`script`
```gml
ce_axis_check(device, axis, direction[, state])
```

## Description
Checks whether a gamepad axis has given state.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| device | `real` | The gamepad device. |
| axis | `real` | The axis to check. |
| direction | `CE_EInputDirection` | The direction in which the axis should be held. |
| [state] | `CE_EInputState` | The state to check for. Defaults to `CE_EInputState.Down`. |

## Returns
`real` A value in range 0..1.