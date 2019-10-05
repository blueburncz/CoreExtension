# ce_change_state
`script`
```gml
ce_change_state(stateMachineComponent, state)
```

## Description
Sets a new state of a state machine component and triggers the
 [CE_EV_STATE_CHANGED](./CE_EV_STATE_CHANGED.html) event with
 `[stateMachineComponent, previousState]` as the event data.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| stateMachineComponent | `real` | The id of the state machine component instance. |
| state | `real` | The id of the new state. |

### See
[ce_set_state](ce_set_state.html), [CE_EV_STATE_CHANGED](CE_EV_STATE_CHANGED.html)