# Creating custom components
The component system is built upon the [Class system](./ClassSystem.html), so it is recommended to first see the its manual and get a good grasp of its concepts. The component system then just introduces a few conventions that every component should abide to.

## Component class definition
Every component must inherit from the [ce_component_class](./ce_component_class.html). You can optionally mark your components as final to disable inheriting from them.

```gml
/// @func ai_component()
CE_PRAGMA_ONCE;
var _ai_component = ce_class_create(ce_component_class);
```

## Methods bound to events
If a component needs to run a piece of code in a specific event, that code should be written in form of a method of the component class. The method should be named based on in which event it should be executed. Currently these method names are supported:

Method | Description | Called automatically
----- | ----------- | --------------------
on_add | A method called when a component is added to an instance. | Yes
on_custom_event | A method which should be called when a user event occurs (see the [Event system](./EventSystem.html) manual for more information). | No
on_draw | A method which should be called every frame in the Draw event. | No
on_init | A method called when a component is created. | Yes
on_remove | A method called when a component is removed from an instance. | Yes
on_update | A method which should be called every frame in the Step event. | No

These methods always take a single parameter, which is the id of the component object. Methods that are not called automatically have to be called using [ce_call_components](./ce_call_components.html) (or using [ce_call](./ce_call.html) for each component).

Additionally you can also use a [destructor](./ClassDestructor.html) to define what should happen when a component is destroyed (either by removing it from an instance or when the instance destroys it in its Clean Up event).

Technically you can create any methods with any names and call them from any events, but to assure compatibility with future updates, you should try to limit yourself to the methods listed above.