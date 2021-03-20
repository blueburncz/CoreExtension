# CE
> A collection of CC0 programming libraries for GameMaker Studio 2

[![License](https://img.shields.io/github/license/kraifpatrik/ce)](LICENSE)
[![Discord](https://img.shields.io/discord/298884075585011713?label=Discord)](https://discord.gg/ep2BGPm)

Donate: [PayPal.Me](https://www.paypal.me/kraifpatrik/1usd)

# Table of Contents
* [License](#license)
* [Documentation](#documentation)
* [Contents](#contents)
  * [Array utils](#array-utils)
  * [Assert](#assert)
  * [Color utils](#color-utils)
  * [Config](#config)
  * [Cubemap](#cubemap)
  * [Draw utils](#draw-utils)
  * [Event system](#event-system)
  * [Hex](#hex)
  * [Instance utils](#instance-utils)
  * [Iter](#iter)
  * [List utils](#list-utils)
  * [Map utils](#map-utils)
  * [Math misc](#math-misc)
  * [Matrix](#matrix)
  * [Native array](#native-array)
  * [Object utils](#object-utils)
  * [Quaternion](#quaternion)
  * [Real utils](#real-utils)
  * [String utils](#string-utils)
  * [Struct utils](#struct-utils)
  * [Surface utils](#surface-utils)
  * [Time](#time)
  * [Tween](#tween)
  * [UUID](#uuid)
  * [Vec2](#vec2)
  * [Vec3](#vec3)
  * [Vec4](#vec4)
  * [XML](#XML)
* [Projects using CE](#projects-using-ce)
* [Links](#links)

# License
CE is released under the CC0 license, which means you can use it for free without giving its authors any credits whatsoever! See [LICENSE](LICENSE) for the full license text.

# Documentation and help
CE is fully documented using the [GMDoc](https://github.com/kraifpatrik/gmdoc) format. An HTML documentation currently isn't hosted online, but you can build one yourself using the GMDoc tool. Please refer to its manual for more info. If you need any additional help with CE, feel free to contact me on the GMC forums or Discord (see [Links](#links)).

# Contents
This section should contain a quick overview of each individual library within CE, but it is still heavily under construction. Sorry for the inconvenience!

## Array utils
**Resources:**
[ce_array_utils](scripts/ce_array_utils/ce_array_utils.gml)

**Dependencies:**
None

## Assert
**Resources:**
[ce_assert](scripts/ce_assert/ce_assert.gml)

**Dependencies:**
[Config](#config)

## Color utils
**Resources:**
[ce_color_utils](scripts/ce_color_utils/ce_color_utils.gml)

**Dependencies:**
None

## Config
**Resources:**
[ce_config](scripts/ce_config/ce_config.gml)

**Dependencies:**
None

## Cubemap
**Resources:**
[ce_cubemap](scripts/ce_cubemap/ce_cubemap.gml)

**Dependencies:**
[Surface utils](#surface-utils), [Vec3](#vec3)

## Draw utils
**Resources:**
[ce_draw_utils](scripts/ce_draw_utils/ce_draw_utils.gml)

**Dependencies:**
None

## Event system
**Resources:**
[ce_draw_utils](scripts/ce_draw_utils/ce_draw_utils.gml),
[CE_SprRectangle](sprites/CE_SprRectangle/CE_SprRectangle.yy)

**Dependencies:**
None

## Hex
**Resources:**
[ce_hex](scripts/ce_hex/ce_hex.gml)

**Dependencies:**
None

## Instance utils
**Resources:**
[ce_instance_utils](scripts/ce_instance_utils/ce_instance_utils.gml)

**Dependencies:**
None

## Iter
**Resources:**
[ce_iter](scripts/ce_iter/ce_iter.gml)

**Dependencies:**
[Assert](#assert)

## List utils
**Resources:**
[ce_list_utils](scripts/ce_list_utils/ce_list_utils.gml)

**Dependencies:**
None

## Map utils
**Resources:**
[ce_map_utils](scripts/ce_map_utils/ce_map_utils.gml)

**Dependencies:**
None

## Math misc
**Resources:**
[ce_math_misc](scripts/ce_math_misc/ce_math_misc.gml)

**Dependencies:**
None

## Matrix
**Resources:**
[ce_matrix](scripts/ce_matrix/ce_matrix.gml)

**Dependencies:**
[Array utils](#array-utils),
[Quaternion](#quaternion)

## Native array
**Resources:**
[ce_native_array](scripts/ce_native_array/ce_native_array.gml)

**Dependencies:**
None

## Object utils
**Resources:**
[ce_object_utils](scripts/ce_object_utils/ce_object_utils.gml)

**Dependencies:**
None

## Quaternion
**Resources:**
[ce_quaternion](scripts/ce_quaternion/ce_quaternion.gml)

**Dependencies:**
[Vec3](#Vec3)

## Real utils
**Resources:**
[ce_real_utils](scripts/ce_real_utils/ce_real_utils.gml)

**Dependencies:**
[String utils](#string-utils)

## String utils
**Resources:**
[ce_string_utils](scripts/ce_string_utils/ce_string_utils.gml)

**Dependencies:**
None

## Struct utils
**Resources:**
[ce_struct_utils](scripts/ce_struct_utils/ce_struct_utils.gml)

**Dependencies:**
None

## Surface utils
**Resources:**
[ce_surface_utils](scripts/ce_surface_utils/ce_surface_utils.gml),
[CE_ShClearColor](shaders/CE_ShClearColor/CE_ShClearColor.yy),
[CE_ShGaussianBlur](shaders/CE_ShGaussianBlur/CE_ShGaussianBlur.yy)

**Dependencies:**
None

## Time
**Resources:**
[ce_time](scripts/ce_time/ce_time.gml)

**Dependencies:**
None

## Tween
**Resources:**
[ce_tween](scripts/ce_tween/.gml)

**Dependencies:**
None

## UUID
**Resources:**
[ce_uuid](scripts/ce_uuid/ce_uuid.gml)

**Dependencies:**
[Hex](#hex)

## Vec2
**Resources:**
[ce_vec2](scripts/ce_vec2/ce_vec2.gml)

**Dependencies:**
[Vec4](#vec4)

## Vec3
**Resources:**
[ce_vec3](scripts/ce_vec3/ce_vec3.gml)

**Dependencies:**
[Vec4](#vec4)

## Vec4
**Resources:**
[ce_vec4](scripts/ce_vec4/ce_vec4.gml)

**Dependencies:**
None

## XML
**Resources:**
[ce_xml](scripts/ce_xml/ce_xml.gml)

**Dependencies:**
[Real utils](#real-utils)

# Projects using CE
* [BBMOD](https://marketplace.yoyogames.com/assets/9424/bbmod)
* Your project here?

# Links
* [Discord](https://discord.gg/ep2BGPm) - If you need help with using CE, you can find me on the [BlueBurn](https://blueburn.cz/) Discord server.
* [GameMaker Community](https://forum.yoyogames.com/index.php?threads/62585) - Or you can use this dedicated forum thread.
* [GMDoc](https://github.com/kraifpatrik/gmdoc) - Used to generate HTML documentation.
* [Xpanda](https://github.com/GameMakerDiscord/Xpanda) - Used to create and manage shaders.
