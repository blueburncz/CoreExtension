# ce_get_component
`script`
```gml
ce_get_component(id, component)
```

## Description
Retrieves instance's component of given class.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the instance. |
| component | `real` | The index of the component class definition script. |

## Returns
`bool` The id of the component instance or `noone` if the instance
 does not have a component of given class.