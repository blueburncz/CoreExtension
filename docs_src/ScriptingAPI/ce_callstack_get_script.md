# ce_callstack_get_script
`script`
```gml
ce_callstack_get_script([level])
```

## Description
Gets a script index from the callstack.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| [level] | `real` | 0 means the script from which this one was called, 1 means the script which called another script from which this one was  called etc. Defaults to 0. |

## Returns
`real` The index of the script or -1 if there is not a script
 in the callstack on given level.