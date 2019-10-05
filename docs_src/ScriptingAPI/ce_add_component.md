# ce_add_component
`script`
```gml
ce_add_component(id, component)
```

## Description
Adds a component to an instance.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance to which the component should be added. |
| component | `real` | The index of the component class definition script. |

## Returns
`real` The id of the created component instance or `noone` if the
 component was not added to the instance.

## Example
Following code initalizes the component system within the calling instance
and adds the timer component to it.
```gml
ce_init_components();
timerComponent = ce_add_component(ce_timer_component);
```

## Note
 This also triggers a custom event [CE_EV_COMPONENT_ADDED](./CE_EV_COMPONENT_ADDED.html)
within the instance.

### See
[ce_init_components](ce_init_components.html), [CE_EV_COMPONENT_ADDED](CE_EV_COMPONENT_ADDED.html)