# ce_input_get_assigned_gamepad
`script`
```gml
ce_input_get_assigned_gamepad(id[, defaultToMain])
```

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance. |
| [defaultToMain] | `bool` | True to default to the main gamepad if the instance has no gamepad assigned. |

## Returns
`real` The id of the gamepad assigned to the instance. If no gamepad
 is assigned to the instance and `defaultToMain` is set to `true`, then the id
 of the main gamepad is returned, otherwise `-1`.

### See
[ce_input_assign_gamepad](ce_input_assign_gamepad.html)