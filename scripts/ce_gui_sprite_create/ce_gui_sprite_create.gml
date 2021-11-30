/// @func ce_gui_sprite_create(_sprite[, _index[, _x[, _y[, _color[, _alpha]]]]])
/// @desc Creates a new widget from the sprite.
/// @param {real} _sprite The sprite.
/// @param {real} [_index] The sprite subimage index. Defaults to 0.
/// @param {real} [_x] The x position of the sprite. Defaults to 0.
/// @param {real} [_y] The y position of the sprite. Defaults to 0.
/// @param {real} [_color] The color to blend the sprite with. Defaults
/// to `c_white`.
/// @param {real} [_alpha] The sprite alpha. Defaults to 1.
/// @return {real} The id of the created widget.
function ce_gui_sprite_create(_sprite, _index=0, _x=0, _y=0, _color=c_white, _alpha=1)
{
	var _w = ce_gui_widget_create();
	_w[? "backgroundSprite"] = _sprite;
	_w[? "backgroundIndex"] = _index;
	_w[? "x"] = _x;
	_w[? "y"] = _y;
	_w[? "backgroundSpriteBlend"] = _color;
	_w[? "backgroundSpriteAlpha"] = _alpha;
	_w[? "width"] = sprite_get_width(_sprite);
	_w[? "height"] = sprite_get_height(_sprite);
	return _w;
}