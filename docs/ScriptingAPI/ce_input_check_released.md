# ce_input_check_released
`script`
```gml
ce_input_check_released(action[, controller])
```

## Description
Checks whether a control for an action in the current input scheme is released.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| action | `any` | The id of the action. |
| [controller] | `real` | The id of the controller device to check. Defaults to the id of the assigned controller or the main controller, if no  controller is assigned to the instance. |

## Returns
`real` Values in range 0..1, where 0 means pressed and 1 means released.

### See
[ce_input_set_scheme](ce_input_set_scheme.html)