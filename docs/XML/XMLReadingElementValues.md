# Reading element values
If an element has a closing pair and no child elements, it is possible to retrieve the value in between using [ce_xml_elem_get_value](./ce_xml_elem_get_value.html). The value is automatically converted into a number if possible, otherwise it is returned as a string.

Given the following XML document

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

following code would retrieve the health of the player from the value of the `<health>` element.

```gml
var _save = ce_xml_read("save.xml");
if (_save != noone)
{
    var _player = ce_xml_elem_find(_save, "player");
    OPlayer.hp = ce_xml_elem_find(_save, "health");
    ce_xml_elem_destroy(_save);
}
```