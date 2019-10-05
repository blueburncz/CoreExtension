# Returning values
It is also possible to return values from within the custom events using the function [ce_event_return](./ce_event_return.html). The instance that triggered the event will then receive the value as the return value of [ce_trigger_event](./ce_trigger_event.html) (or [ce_trigger_event_global](./ce_trigger_event_global.html)). Important thing to know is that if a custom event is triggered globally, then only the return value of the last instance it was triggered in is returned!

```gml
/// @desc User Event
switch (ce_get_event())
{
case "add":
    var _numbers = ce_get_event_data();
    ce_event_return(_numbers[0] + _numbers[1]);
    break;
}

/// Test
ce_trigger_event("add", [1, 2]); // => 3
```