# ce_string_explode
`script`
```gml
ce_string_explode(string, delimiter)
```

## Description
Splits the string on every occurence of the delimiter and puts
 the resulting substrings into an array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| string | `string` | The string to split. |
| delimiter | `string` | The string to split on. |

## Returns
`array` The array of substrings.

## Example
This creates an array `["Hello", " World!"]`.
```
string_explode("Hello, World!", ",");
```