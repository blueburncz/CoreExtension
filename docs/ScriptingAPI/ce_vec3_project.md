# ce_vec3_project
`script`
```gml
ce_vec3_project(vector, screen, worldViewProjection)
```

## Description
Projects the vector from world space into screen space.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| vector | `array` | The vector. |
| screen | `array` | An array containing `[screenWidth, screenHeight]`. |
| worldViewProjection | `array` | The world * view * projection matrix. |