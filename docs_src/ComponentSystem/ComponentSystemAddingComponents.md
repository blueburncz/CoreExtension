# Adding components
After an instance initializes the component system, we can add components to it using [ce_add_component](./ce_add_component.html). Instances can have multiple components of the same type. The function above returns the id the created component, which can be used to access its data, call its method or to remove it from the instance.

```gml
/// @desc Create event
ce_init_components();
state_machine_component = ce_add_component(id, ce_state_machine_component);
timer_component = ce_add_component(id, ce_timer_component);
```

Adding components to instances also triggers a custom event
[CE_EV_COMPONENT_ADDED](./CE_EV_COMPONENT_ADDED.html) within the target instance. The event data will contain the id of the created component.

```gml
/// @desc User Event
switch (ce_get_event())
{
case CE_EV_COMPONENT_ADDED:
    var _component = ce_get_event_data();
    switch (ce_class_of(_component))
    {
    case ce_state_machine_component:
        // Do something when a state machine component is added...
        break;

    case ce_timer_component:
        // Do something when a timer component is added...
        break;
    }
    break;
}
```