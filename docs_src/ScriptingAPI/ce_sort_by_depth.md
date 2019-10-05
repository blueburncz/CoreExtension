# ce_sort_by_depth
`script`
```gml
ce_sort_by_depth(depthSortComponent, depth)
```

## Description
Sorts an instance containing given depth sort component by given value.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| depthSortComponent | `real` | The id of the depth sort component instance. |
| depth | `real` | The depth to sort by. Smaller values mean closer to the camera, larger values mean farther from the camera. |

## Example
Following code gets a list of objects containing the depth sort component
and sorts them by their position on the *y* axis.
```gml
var _objects = ce_objects_with_component(true, ce_depth_sort_component);
while (ce_iter(_objects, ds_type_list))
{
    with (CE_ITER_VALUE)
    {
        ce_sort_by_depth(depthSortComponent, -y);
    }
}
ds_list_delete(_objects);
```