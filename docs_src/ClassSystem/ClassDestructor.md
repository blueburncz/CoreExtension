# Destructor
When an object is no longer needed, you have to destroy it manually using function [ce_delete](./ce_delete.html), otherwise it would be kept in memory.

It is often useful to define what should happen when an instance of a class is destroyed. For example if it contains a data structure, its necessary to destroy the data structure as well to prevent memory leaks. We call a script that is executed upon deletion of an object a *destructor*. To define a destructor of a class, use the function [ce_class_define_destructor](./ce_class_define_destructor.html). The function expects the class type and the index of the script as parameters. The script itself must take a single argument, which will be an id of a destroyed instance.

```gml
/// @func iterative_class()
CE_PRAGMA_ONCE;
var _iterative_class = ce_class_create();
ce_class_define_destructor(_iterative_class, iterative_delete);

/// @func iterative_delete()
show_debug_message("Iterative destroyed");

/// @func list_class()
CE_PRAGMA_ONCE;
var _list_class = ce_class_create(iterative_class);
ce_class_define_properties(_list_class, [
    "list", noone,
    "_init", list_init,
]);
ce_class_define_destructor(_list_class, list_delete);

/// @func list_init(id)
var _list = argument[0];
ce_set_prop(_list, "list", ds_list_create());
ce_super(_list, "_init");

/// @func list_delete(id)
ds_list_destroy(ce_get_prop(argument0, "list"));
show_debug_message("List destroyed");

/// @func list_create()
var _list = ce_make_instance(list_class);
ce_call(_list, "_init");
return _list;

/// Test
var _list = list_create();
ce_delete(_list);
// Prints "List destroyed"
// Prints "Iterative destroyed"
```

When an object is destroyed, superclass destructors are executed automatically. If class *A* inherits from class *B* which inherits from class *C* and an object of *A* is destroyed, then the destructor of class *A* is called first, then the destructor of class *B* and lastly the destructor of class *C*.