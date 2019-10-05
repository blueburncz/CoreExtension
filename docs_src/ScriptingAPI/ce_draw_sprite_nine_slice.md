# ce_draw_sprite_nine_slice
`script`
```gml
ce_draw_sprite_nine_slice(sprite, subimage, x, y, width, height, tiled[, color[, alpha]])
```

## Description
Draws a nine-slice sprite.

### Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| sprite | `real` | The nine slice sprite to draw. |
| subimage | `real` | The subimage of the sprite to draw. |
| x | `real` | The x position to draw the sprite at. |
| y | `real` | The y position to draw the sprite at. |
| width | `real` | The width to which the sprite should be stretched. |
| height | `real` | The height to which the sprite should be stretched. |
| tiled | `bool` | True to tile the sprite of false to stretch. |
| [color] | `real` | The color to blend the sprite with. Defaults to `c_white`. |
| [alpha] | `real` | The opacity of the sprite. Defaults to 1. |

## Note
 Currently it is not supported to use width and height smaller than
the size of the original image.