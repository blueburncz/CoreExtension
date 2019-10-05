# ce_input_check_pressed
`script`
```gml
ce_input_check_pressed(action[, controller])
```

## Description
Checks whether a control for an action in the current input scheme is pressed.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| action | `string/real` | The id of the action. |
| [controller] | `real` | The id of the controller device to check. Defaults to the id of the assigned controller or the main controller, if no  controller is assigned to the instance. |

## Returns
`real` Values in range 0..1, where 0 means not pressed and 1 means pressed.

### See
[ce_input_set_scheme](ce_input_set_scheme.html)