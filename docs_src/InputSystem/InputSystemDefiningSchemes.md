# Defining schemes
Once we have our actions defined, we can create input schemes and add the actions to them. To create a new input scheme, use the function [ce_input_scheme_create](./ce_input_scheme_create.html). It is important to keep the return value for later use, so in this example we are going to store it into a global variable.

```gml
global.scheme_default = ce_input_scheme_create("Default");
```

To add actions into an input scheme, use the function [ce_input_scheme_add_action](./ce_input_scheme_add_action.html).

```gml
ce_input_scheme_add_action(global.scheme_default, EAction.MoveLeft);
ce_input_scheme_add_action(global.scheme_default, EAction.MoveRight);
ce_input_scheme_add_action(global.scheme_default, EAction.Jump);
ce_input_scheme_add_action(global.scheme_default, EAction.Attack);
```

At this point we have the actions added to the input scheme, but they do not have any keys bound to them, so they cannot be triggered. You can bind input to actions using functions [ce_input_scheme_bind_axis](./ce_input_scheme_bind_axis.html), [ce_input_scheme_bind_gamepad](./ce_input_scheme_bind_gamepad.html), [ce_input_scheme_bind_keyboard](./ce_input_scheme_bind_keyboard.html), [ce_input_scheme_bind_mouse](./ce_input_scheme_bind_mouse.html) and [ce_input_scheme_bind_mouse_wheel](./ce_input_scheme_bind_mouse_wheel.html).

```gml
ce_input_scheme_add_action(global.scheme_default, EAction.MoveLeft);
ce_input_scheme_bind_keyboard(global.scheme_default, EAction.MoveLeft, ord("A"));
ce_input_scheme_bind_axis(global.scheme_default, EAction.MoveLeft, gp_axislh,
    CE_EInputDirection.Left);

ce_input_scheme_add_action(global.scheme_default, EAction.MoveRight);
ce_input_scheme_bind_keyboard(global.scheme_default, EAction.MoveRight, ord("D"));
ce_input_scheme_bind_axis(global.scheme_default, EAction.MoveRight, gp_axislh,
    CE_EInputDirection.Right);

ce_input_scheme_add_action(global.scheme_default, EAction.Jump);
ce_input_scheme_bind_keyboard(global.scheme_default, EAction.Jump, vk_space);
ce_input_scheme_bind_gamepad(global.scheme_default, EAction.Jump, gp_face1);

ce_input_scheme_add_action(global.scheme_default, EAction.Attack);
ce_input_scheme_bind_mouse(global.scheme_default, EAction.Attack, mb_left);
ce_input_scheme_bind_gamepad(global.scheme_default, EAction.Attack, gp_face3);
```

If a script requires a direction of an input (for example for the joysticks), use values from the enum [CE_EInputDirection](./CE_EInputDirection.html). This enum is defined in the script [ce_input_config](./ce_input_config.html), where you can also find enums [CE_EInputState](./CE_EInputState.html) and [CE_EInputType](./CE_EInputType.html) for input states (pressed, released, etc.) and types (gamepad button, mouse wheel, etc.).

The input system allows you to configure maximum number of keys bound per a controller type through the macro [CE_INPUT_MAX_BINDINGS](./CE_INPUT_MAX_BINDINGS.html), which is defined in the script [ce_input_config](./ce_input_config.html). See the contents of the script for more configuration macros.