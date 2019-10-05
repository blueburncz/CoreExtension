# Loading a file
To load an XML file, use the function [ce_xml_read](./ce_xml_read.html). This function loads the entire file into a tree like structure of nodes, which we call *elements*. The top level element is called a *root*. The return value of the function is either the id of the root element on success or the constant `noone` on fail. The id of the root can be then used to access the rest of the elements.

After you are finished working with the loaded data, do not forget to free it from memory using [ce_xml_elem_destroy](./ce_xml_elem_destroy.html).

Given the following XML document

```xml
<enemies>
  <enemy x="10" y="20"/>
  <enemy x="30" y="40"/>
</enemies>
```

the variable `_enemies` from the following code would contain the id of the `<enemies>` element, which is the root of the document.

```gml
var _enemies = ce_xml_read("enemies.xml");
if (_enemies != noone)
{
    // Process loaded data here...
    ce_xml_elem_destroy(_enemies);
}
```