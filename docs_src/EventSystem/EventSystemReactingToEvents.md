# Reacting to events
When a custom event is triggered within an instance, the configured User Event is triggered (see the [Configuration](./EventSystemConfiguration.html) section) from where you can read the event's id using [ce_get_event](./ce_get_event.html) and data using [ce_get_event_data](./ce_get_event_data.html).

```gml
/// @desc User Event
switch (ce_get_event())
{
case EV_GOT_HIT:
    hp -= ce_get_event_data();
    if (hp <= 0)
    {
        instance_destroy();
    }
    break;

case EV_GAME_PAUSED:
    image_speed = 0;
    break;

case EV_GAME_UNPAUSED:
    image_speed = 1;
    break;
}
```