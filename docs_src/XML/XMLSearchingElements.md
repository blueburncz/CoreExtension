# Searching elements
If you want to find an element of a specific name within an XML document of a more complicated structure without iterating it by hand, use the function [ce_xml_elem_find](./ce_xml_elem_find.html). This function checks the name of the element passed as a parameter, if it is equal, then it returns its id, otherwise recursively traverses its child elements until the first element with a matching name is found. If no element is found, then it returns `noone`.

In case you want to find *all* elements of a specific name, use the function [ce_xml_elem_find_all](./ce_xml_elem_find_all.html). This function does not stop at the first found element with a matching name, instead it recursively traverses all child elements and puts ids of those with a matching name into a list. The id of the list is then returned. Do not forget to destroy the list if its no longer needed.

Given following XML document

```xml
<level>
    <instances>
        <player x="0" y="0"/>
        <enemy x="10" y="20"/>
        <enemy x="30" y="40"/>
        <boss x="50" y="60"/>
    </instances>
</level>
```

code `ce_xml_elem_find(_level, "boss")` would find the `<boss>` element and return its id. If we wanted to find and iterate all `<enemy>` elements, we could do so using the following code.

```gml
var _enemies = ce_xml_elem_find(_level, "enemy");
while (ce_iter(_enemies, ds_type_list))
{
    var _enemy = CE_ITER_VALUE;
    // Process enemy data here...
}
ds_list_destroy(_enemies);
```

Note that [ce_iter](./ce_iter.html) is used to iterate the list. Please see its [documentation](./ce_iter.html) for more information on how it works.