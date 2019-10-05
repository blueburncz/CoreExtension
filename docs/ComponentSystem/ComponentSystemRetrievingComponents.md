# Retrieving components
If you want retrieve an instance's component of a specific type, you can do so using function [ce_get_component](./ce_get_component.html). This function returns the constant `noone` if the instance does not have such component. You can first check whether an instance has a component using function [ce_has_component](./ce_has_component.html).

```gml
/// @desc Collision event
if (ce_has_component(id, health_component)
    && ce_has_component(other.id, damage_component))
{
    var _healthComponent = ce_get_component(id, health_component);
    var _damageComponent = ce_get_component(other.id, damage_component);
    var _damageDealt = ce_get_prop(_damageComponent, "damage");
    var _newHealth = ce_get_prop(_healthComponent, "health") - _damageDealt;
    ce_set_prop(_healthComponent, "health", _newHealth);
}
```

Instances can have multiple components of the same type. To retrieve a list of all components of a type, use the function [ce_list_components](./ce_list_components.html). Do not forget to destroy the list when you are done using it to prevent memory leaks.

```gml
var _lights = ce_list_components(id, light_component);
while (ce_iter(_lights, ds_type_list))
{
    var _lightComponent = CE_ITER_VALUE;
    var _randomColor = make_color_hsv(irandom(255), 255, 255);
    ce_set_prop(_lightComponent, "color", _randomColor);
}
ds_list_destroy(_lights);
```

The functions above retrieve components of an instance, but sometimes it can be handy to retrieve objects that have specific components. This can be done using function [ce_objects_with_component](./ce_objects_with_component.html). This function also returns a list, so do not forget to destroy it when it is no longer needed.

Following is a code showing what could a rendering system using components look like.

```gml
var _matrixWorld = matrix_get(matrix_world);
var _renderable = ce_objects_with_component(true, transform_component,
    mesh_component);

while (ce_iter(_renderable, ce_type_list))
{
    with (CE_ITER_VALUE)
    {
        var _transformComponent = ce_get_component(id, transform_component);
        var _meshComponent = ce_get_component(id, mesh_component);
        matrix_set(matrix_world, ce_get_prop(_transformComponent, "matrix"));
        ce_call(_meshComponent, "submit");
    }
}

matrix_set(matrix_world, _matrixWorld);
ds_list_destroy(_renderable);
```