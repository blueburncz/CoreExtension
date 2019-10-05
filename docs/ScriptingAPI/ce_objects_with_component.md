# ce_objects_with_component
`script`
```gml
ce_objects_with_component(ancestorsOnly, component, ...)
```

## Description
Creates a list containing objects (not instances) which have all of
 the given components.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| ancestorsOnly | `bool` | If set to true, then only ancestor objects will be kept within the list. This is useful if you want to use the list in a  `with` clause and avoid accessing single instance multiple times. |
| component | `real` | The index of the component class definition script. |

## Returns
`real` The id of the list.

## Note
 Make sure to destroy the list when it's no longer necessary.