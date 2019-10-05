# ce_timer_get_callback
`script`
```gml
ce_timer_get_callback(timer)
```

## Description
Retrieves the index of the callback script of a timer.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| timer | `real` | The id of the timer instance. |

## Returns
`real` The index of the callback script or `noone` if the timer
 does not have any.