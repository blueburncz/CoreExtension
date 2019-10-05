# ce_quaternion_create_look_rotation
`script`
```gml
ce_quaternion_create_look_rotation(forward, up)
```

## Description
Creates a quaternion with the specified forward and up vectors. These
 vectors must not be parallel! If they are, then an identity quaternion
 will be returned.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| forward | `array` | The 3D forward unit vector. |
| up | `array` | The 3D up unit vector. |

## Returns
`array` An array representing the quaternion.