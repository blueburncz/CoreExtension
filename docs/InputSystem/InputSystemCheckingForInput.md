# Checking for input
When you have an input scheme defined and actions added to it, you can check whether the player is pressing any of the keys bound to a specific action. Before we do so, we have to first make sure that following points are met:

* You have specified the current input scheme using [ce_input_set_scheme](./ce_input_set_scheme.html).
* The function [ce_input_update](./ce_input_update.html) is called once per every frame (in the Step event for example). This is necessary for the input system to work properly.

To check whether any key bound to a specific action is held down, pressed or released, use the functions [ce_input_check_down](./ce_input_check_down.html), [ce_input_check_pressed](./ce_input_check_pressed.html) and [ce_input_check_released](./ce_input_check_released.html) respectively. These functions optionally take an id of a gamepad as a parameter and if it is not passed, then it defaults to the main gamepad. See the section [Assigning gamepads](./InputSystemAssigningGamepads.html) for more information.

```gml
ce_input_update();

if (ce_input_get_binding_action() != noone)
{
    // Disable controls when binding keys
    exit;
}

hspeed = (ce_input_check_down(EAction.MoveRight)
    - ce_input_check_down(EAction.MoveLeft));

if (ce_input_check_pressed(EAction.Jump))
{
    vspeed = -10;
}

if (ce_input_check_pressed(EAction.Attack))
{
    instance_create_layer(x, y, layer, OBullet);
}
```

As you can see, function [ce_input_get_binding_action](./ce_input_get_binding_action.html) is used to disable controls when the player is currently binding keys to an action. See the section [Binding keys in-game](./InputSystemBindingKeysInGame.html) for more information about binding keys.