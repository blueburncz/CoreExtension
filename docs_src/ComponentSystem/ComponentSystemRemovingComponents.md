# Removing components
To remove a component from an instance, use the function [ce_remove_component](./ce_remove_component.html). This also triggers a custom event [CE_EV_COMPONENT_REMOVED](./CE_EV_COMPONENT_REMOVED.html) within the target instance. The event data will contain the id of the removed component and the event is triggered before the component is destroyed, so the id can be still used to access the components data, call its methods etc.

```gml
/// @desc User Event
switch (ce_get_event())
{
case CE_EV_COMPONENT_REMOVED:
    var _component = ce_get_event_data();
    if (_component == timer_component)
    {
        // Do something when a specific timer component stored in
        // the timer_component variable is removed...
    }
    if (ce_is_instance(_component, ce_timer_component))
    {
        // Do something when a timer component is removed...
    }
    break;
}
```