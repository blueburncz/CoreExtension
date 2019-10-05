# Defining actions
The first step required to start utilizing the input system is to define actions which the player can trigger using a controller. Examples of such actions could be *move left*, *move right*, *jump* and *attack*. Once we have our list of actions, we have to assign a constant unique id to each one of them. An action id can be either a string or an integer. A good way to define the ids is either using macros or enums. We will be using enums in this example.

```gml
enum EActions
{
    MoveLeft,
    MoveRight,
    Jump,
    Attack,
};
```

The second step is to associate action ids with special structures which keep a human readable name of the action and possibly other metadata in future updates. This is done using the function [ce_input_action_create](./ce_input_action_create.html).

```gml
ce_input_action_create(EAction.MoveLeft, "Move left");
ce_input_action_create(EAction.MoveRight, "Move right");
ce_input_action_create(EAction.Jump, "Jump");
ce_input_action_create(EAction.Attack, "Attack");
```

This should be done only once for each action id, so a good place to do so may be some kind of initialization room which is visited only once per game session. Also make sure to create the actions before you try to use them in other input system scripts.