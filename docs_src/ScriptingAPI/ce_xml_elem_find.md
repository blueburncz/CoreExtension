# ce_xml_elem_find
`script`
```gml
ce_xml_elem_find(rootElement, name)
```

## Description
Finds the first element with given name in the given tree of elements.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| rootElement | `real` | The root element of the tree. |
| name | `string` | The name of the element to be found. |

## Returns
`real` The id of the found element or noone, if no such element has
 been found.