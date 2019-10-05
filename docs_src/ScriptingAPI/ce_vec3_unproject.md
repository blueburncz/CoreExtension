# ce_vec3_unproject
`script`
```gml
ce_vec3_unproject(vector, screen, invWorldViewProjection)
```

## Description
Unprojects the vector from screen space to world space.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| vector | `array` | The vector in screen space. |
| screen | `array` | An array containing `[screenWidth, screenHeight]`. |
| invWorldViewProjection | `array` | The inverse world * view * projection matrix. |