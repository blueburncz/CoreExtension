# Creating a document
Using the XML library, you can also create and save your own documents. Firstly, you will need to create the root element which will contain the rest of the elements. To create a new element, use the function [ce_xml_elem_create](./ce_xml_elem_create.html). Child elements can be added using [ce_xml_elem_add_child](./ce_xml_elem_add_child.html). Element attributes and values can be added / modified using [ce_xml_elem_set_attribute](./ce_xml_elem_set_attribute.html) and [ce_xml_elem_set_value](./ce_xml_elem_set_value.html) respectively.

```gml
// Create root node
var _save = ce_xml_elem_create("save");

// Save player data
var _player = ce_xml_elem_create("player");
with (OPlayer)
{
    var _health = ce_xml_elem_create("health");
    ce_xml_elem_set_value(_health, health);
    ce_xml_elem_add_child(_player, _health);
}
ce_xml_elem_add_child(_save, _player);

// Save enemies
var _enemies = ce_xml_elem_create("enemies");
with (OEnemy)
{
    var _enemy = ce_xml_elem_create("enemy");
    ce_xml_elem_set_attribute(_enemy, "x", x);
    ce_xml_elem_set_attribute(_enemy, "y", y);
    ce_xml_elem_add_child(_enemies, _enemy);
}
ce_xml_elem_add_child(_save, _enemies);
```

The code above could create a document looking like this

```xml
<save>
    <player>
        <health>100</health>
    </player>
    <enemies>
        <enemy x="65" y="98"/>
        <enemy x="32" y="41"/>
    </enemies>
</save>
```

To turn a tree of elements into a string, use the function [ce_xml_write](./ce_xml_write.html).

```gml
var _file = file_text_open_write("save.xml");
if (_file != -1)
{
    file_text_write_string(_file, ce_xml_write(_save));
    file_text_close(_file);
}
```

Do not forget to delete the created elements using [ce_xml_elem_destroy](./ce_xml_elem_destroy.html) when they are no longer needed.