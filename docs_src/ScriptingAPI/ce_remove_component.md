# ce_remove_component
`script`
```gml
ce_remove_component(id, component)
```

## Description
Removes a component from an instance.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance to remove the component from. |
| component | `real` | The id of the component instance to be removed. |

## Returns
`bool` True if the component was removed.

## Note
 This also triggers a custom event [CE_EV_COMPONENT_REMOVED](./CE_EV_COMPONENT_REMOVED.html).

### See
[CE_EV_COMPONENT_REMOVED](CE_EV_COMPONENT_REMOVED.html)