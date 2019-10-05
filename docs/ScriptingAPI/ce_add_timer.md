# ce_add_timer
`script`
```gml
ce_add_timer(timerComponent, duration[, callback[, paused]])
```

## Description
Adds a timer to a timer component.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| timerComponent | `real` | The id of the timer component instance to which the timer should be added. |
| duration | `real` | The duration of the timer in milliseconds. |
| [callback] | `real` | The index of the callback script, which is executed at the end of the timer. Use `noone` (default) for no callback. |
| [paused] | `bool` | True to create the timer as paused. |

## Returns
`real` The id of the timer.

## Note
 An event [CE_EV_TIMEOUT](./CE_EV_TIMEOUT.html) is always executed at
the end of a timer with the timer's id as the event data.

### See
[CE_EV_TIMEOUT](CE_EV_TIMEOUT.html)