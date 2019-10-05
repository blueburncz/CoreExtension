# ce_trigger_event
`script`
```gml
ce_trigger_event(event[, data[, global]])
```

## Description
Triggers the custom event.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| event | `any` | The id of the event. |
| [data] | `any` | Additional event data. |
| [global] | `bool` | True to trigger the event within all instances, false to only within the calling instance. |

## Returns
`any` The event result.

### See
[ce_event_return](ce_event_return.html)