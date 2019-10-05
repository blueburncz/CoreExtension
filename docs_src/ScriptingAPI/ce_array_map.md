# ce_array_map
`script`
```gml
ce_array_map(array, callback)
```

## Description
Creates a new array containing the results of calling the script on
 every value in the given array.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| array | `array` | The array to map. |
| callback | `real` | The script that produces a value of the new array, taking the original value as the first argument and optionally it's index  as the second argument. |