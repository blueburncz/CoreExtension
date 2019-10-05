# Executing components' logic
In the current state of the component system the component methods do not get executed automatically. That means if a component requires some method to be executed each step to work properly, you have to call the method from the Step event yourself. By convention methods that have to be run each step are called "onUpdate". You should always first see the definition script of the component class or its documentation to find out what methods it needs to run.

To execute a method of a single specific component, use the [ce_call](./ce_call.html) function from the [Class system](./ClassSystem.html).

```gml
/// @desc Step
ce_call(aiComponent, "onUpdate");
ce_call(timerComponent, "onUpdate");
```

Doing this for every component could become tedious, so there is a shortcut function [ce_call_components](./ce_call_components.html) which calls a method in all components of an instance.

```gml
/// @desc Step
ce_call_components("onUpdate");
```