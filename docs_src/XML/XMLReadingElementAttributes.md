
# Reading element attributes
To read a value of a specific attribute of an element, use the function [ce_xml_elem_get_attribute](./ce_xml_elem_get_attribute.html).

Given the following XML document

```xml
<enemies>
  <enemy x="10" y="20"/>
  <enemy x="30" y="40"/>
</enemies>
```

following code would iterate through the `<enemy>` elements and spawn instances of an object `OEnemy` on coordinates equal to the *x* and *y* attributes of the element.

```gml
var _enemies = ce_xml_read("enemies.xml");
if (_enemies != noone)
{
    var _child_count = ce_xml_elem_get_child_count(_enemies);
    for (var i = 0; i < _child_count; ++i)
    {
        var _enemy = ce_xml_elem_get_child(_enemies, i);
        instance_create_layer(
            ce_xml_elem_get_attribute(_enemy, "x"),
            ce_xml_elem_get_attribute(_enemy, "y"),
            layer,
            OEnemy);
    }
    ce_xml_elem_destroy(_enemies);
}
```

It is possible that you sometimes may now know the exact structure of the loaded document and you may want to traverse all attributes of some element. To find out how many attributes an element has, use the function [ce_xml_elem_get_attribute_count](./ce_xml_elem_get_attribute_count.html). Given the returned value is greater than 0, you can find the name of the first attribute of an element using the function [ce_xml_elem_find_first_attribute](./ce_xml_elem_find_first_attribute.html). To find names of following attributes, use the function [ce_xml_elem_find_next_attribute](./ce_xml_elem_find_next_attribute.html).

Following code iterates through all attributes of an element.

```gml
var _attribute_count = ce_xml_elem_get_attribute_count(_elem);
if (_attribute_count > 0)
{
    var _attribute_name = ce_xml_elem_find_first_attribute(_elem);
    repeat (_attribute_count)
    {
        var _attribute_value = ce_xml_elem_get_attribute(_elem, _attribute_name);
        // Process attribute value here...
        _attribute_name = ce_xml_elem_find_next_attribute(_elem, _attribute_name);
    }
}
```