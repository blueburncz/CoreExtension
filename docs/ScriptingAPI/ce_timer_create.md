# ce_timer_create
`script`
```gml
ce_timer_create(duration[, callback[, paused]])
```

## Description
Creates a new instance of the timer class.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| duration | `real` | The duration of the timer in milliseconds. |
| [callback] | `real` | The index of the callback script, which is executed at the end of the timer. Use `noone` (default) for no callback. |
| [paused] | `bool` | True to create the timer as paused. |

## Returns
`real` The id of the created instance.