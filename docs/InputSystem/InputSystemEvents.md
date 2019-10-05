# Events
The input system utilizes the [event system](./EventSystem.html) to trigger custom events [CE_EV_GAMEPAD_CONNECTED](./CE_EV_GAMEPAD_CONNECTED.html) and [CE_EV_GAMEPAD_DISCONNECTED](./CE_EV_GAMEPAD_DISCONNECTED.html). Definition of both these events can be found in the script [ce_input_config](./ce_input_config.html). As the events' names suggest, the former is triggered when a new gamepad is connected and the latter when a gamepad is disconnected. The events' data is equal to the id of the gamepad. These events can be used for example for recognition of the main gamepad.

```gml
/// @desc User Event
switch (ce_get_event())
{
case CE_EV_GAMEPAD_CONNECTED:
    if (ce_input_get_main_gamepad() == -1)
    {
        ce_input_set_main_gamepad(ce_get_event_data());
    }
    break;

case CE_EV_GAMEPAD_DISCONNECTED:
    if (ce_input_get_main_gamepad() == ce_get_event_data())
    {
        ce_input_set_main_gamepad(-1);
    }
    break;
}
```

Another example of use could be a local multiplayer, where you could spawn a new player when a gamepad is connected and despawn them when the gamepad is disconnected.

```gml
/// @desc User Event
switch (ce_get_event())
{
case CE_EV_GAMEPAD_CONNECTED:
    // Spawn a new player
    var _gamepad = ce_get_event_data();
    with (instance_create_layer(random(room_width), random(room_height),
        layer, OPlayer))
    {
        ce_input_assign_gamepad(id, _gamepad);
    }
    break;

case CE_EV_GAMEPAD_DISCONNECTED:
    // Despawn player
    var _gamepad = ce_get_event_data();
    var _player = ce_input_get_assigned_instance(_gamepad);
    instance_destroy(_player);
    ce_input_assign_gamepad(noone, _gamepad);
    break;
}
```

Important thing to know is that these events are triggered by the script [ce_input_update](./ce_input_update.html) and only in the instance which calls it!