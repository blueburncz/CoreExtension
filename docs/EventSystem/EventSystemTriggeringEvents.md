# Triggering events
To trigger a custom event, use the function [ce_trigger_event](./ce_trigger_event.html). This function expects a unique id of the event as a parameter and optionally some additional event data and a boolean which tells whether you want to trigger the event only within the calling instance or within all instances.

We suggest you to define your custom events either using macros or enums. In this example we will use macros and strings. It is also a good practice to leave a documentation comment above your event definitions to tell what the event means, what data it contains and whether a return value is expected.

```gml
/// @macro {string} When an instance receives this event, it means it was
/// damaged. The number of damage dealt can be retrieved from the event data.
#macro EV_GOT_HIT "evGotHit"

/// @desc Player's mouse click event
with (OEnemy)
{
    if (point_distance(x, y, other.x, other.y) < other.attackRange)
    {
        ce_trigger_event(EV_GOT_HIT, other.damage);
    }
}
```

For triggering events in all instances there is also a shorthand function [ce_trigger_event_global](./ce_trigger_event_global.html) in case you do not want to specify any event data.

```gml
/// @macro {string} The game was paused.
#macro EV_GAME_PAUSED "evGamePaused"

/// @macro {string} The game was unpaused.
#macro EV_GAME_UNPAUSED "evGameUnpaused"

/// @desc When Escape is pressed
global.gamePaused = !global.gamePaused;
ce_trigger_event_global(global.gamePaused ? EV_GAME_PAUSED : EV_GAME_UNPAUSED);
```