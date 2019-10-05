# ce_set_state
`script`
```gml
ce_set_state(stateMachineComponent, state)
```

## Description
Sets state of a state machine *without* triggering the
 [CE_EV_STATE_CHANGED](./CE_EV_STATE_CHANGED.html) event.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| stateMachineComponent | `real` | The id the state machine component instance. |
| state | `real` | The id of the new state. |

### See
[ce_change_state](ce_change_state.html), [CE_EV_STATE_CHANGED](CE_EV_STATE_CHANGED.html)