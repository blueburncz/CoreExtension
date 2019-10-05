# ce_super
`script`
```gml
ce_super(id, prop[, data])
```

## Description
Calls `script_execute` with a value of an inherited property *prop* as
 the first argument, an *id* of the object as the second argument and *data*
 as the third argument.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| id | `real` | The id of the object. |
| prop | `string/real` | The property identifier. |
| [data] | `any` | The data to be passed as the third argument. Defaults to `undefined`. |

## Returns
`any` The return value of the `script_execute` call or `undefined` if
 the object does not have given property.