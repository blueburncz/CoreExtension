# Traversing elements
Once you have loaded your XML file and you have the id of the root element, you can access its child elements using [ce_xml_elem_get_child](./ce_xml_elem_get_child.html). To access a specific child using that function, you first need to know its index. Indices of child elements are values ranging from 0 to number of child elements minus 1 (e.g. if an element has 3 child elements, their indices would 0, 1 and 2 based on which occurs first in the document).

Sometimes you may not know the exact structure of the loaded document and you may just want to go through all child elements. To find out how many child elements an element has, use the function [ce_xml_elem_get_child_count](./ce_xml_elem_get_child_count.html).

Given the following XML document

```xml
<enemies>
  <enemy x="10" y="20"/>
  <enemy x="30" y="40"/>
</enemies>
```

following code iterates through all the `<enemy>` elements. In the first iteration, the variable `_enemy` would contain the id of the element with the attribute *x* equal to 10 and in the second iteration it would be the id of the element with the attribute *x* equal to 30.

```gml
var _enemies = ce_xml_read("enemies.xml");
if (_enemies != noone)
{
    var _childCount = ce_xml_elem_get_child_count(_enemies);
    for (var i = 0; i < _childCount; ++i)
    {
        var _enemy = ce_xml_elem_get_child(_enemies, i);
        // Process 'enemy' element's data here...
    }
    ce_xml_elem_destroy(_enemies);
}
```