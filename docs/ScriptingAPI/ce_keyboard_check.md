# ce_keyboard_check
`script`
```gml
ce_keyboard_check(key[, state])
```

## Description
Checks whether a keyboard key has given state.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| key | `real` | The keyboard key to check. |
| [state] | `CE_EInputState` | The state to check for. Defaults to `CE_EInputState.Down`. |

## Returns
`bool` True if the key has the expected state.