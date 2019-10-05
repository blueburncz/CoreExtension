# ce_mouse_check
`script`
```gml
ce_mouse_check(button[, state])
```

## Description
Checks whether a mouse button has given state.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| button | `real` | The mouse button to check. |
| [state] | `CE_EInputState` | The state to check for. Defaults to `CE_EInputState.Down`. |

## Returns
`bool` True if the button has the expected state.