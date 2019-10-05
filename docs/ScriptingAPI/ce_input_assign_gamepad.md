# ce_input_assign_gamepad
`script`
```gml
ce_input_assign_gamepad(id, gamepad)
```

## Description
Assigns a gamepad to an instance, so it doesn't have to explicitly
 pass its id to input check scripts.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance. |
| gamepad | `real` | The id of the gamepad. |

### See
[ce_input_get_assigned_gamepad](ce_input_get_assigned_gamepad.html), [ce_input_get_assigned_instance](ce_input_get_assigned_instance.html)