# ce_input_check
`script`
```gml
ce_input_check(action, state[, controller])
```

## Description
Checks whether a control for an action in the current input scheme
 is held down.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| action | `string/real` | The id of the action. |
| state | `CE_EInputState` | The expected state of the control. |
| [controller] | `real` | The id of the controller device to check. Defaults to the id of the assigned controller or the main controller, if no  controller is assigned to the instance. |

## Returns
`real` Values in range 0..1, where 0 means doesn't have given state
 and 1 means has given state.

### See
[ce_input_set_scheme](ce_input_set_scheme.html), [ce_input_assign_gamepad](ce_input_assign_gamepad.html)