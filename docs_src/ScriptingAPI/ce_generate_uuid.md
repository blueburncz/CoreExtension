# ce_generate_uuid
`script`
```gml
ce_generate_uuid([array])
```

## Description
Generates a version 4 UUID.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| [array] | `array` | An array that will be used for storing random bytes. It's size must be 16! If the array is not provided, a new one is created.  Providing the array can save some extra ms when sequentially generating  large numbers of UUIDs. |

## Returns
`string` The generated UUID.

## Note
 Depends on the `_to_hex` functions.

## Source
https://www.cryptosys.net/pki/uuid-rfc4122.html