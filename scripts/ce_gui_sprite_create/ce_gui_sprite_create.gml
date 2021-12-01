/// @func ce_gui_sprite_create(_sprite[, _index[, _x[, _y[, _color[, _alpha]]]]])
/// @desc Creates a new widget from the sprite.
/// @param {real} _sprite The sprite.
/// @param {real} [_index] The sprite subimage index. Defaults to 0.
/// @param {real} [_x] The x position of the sprite. Defaults to 0.
/// @param {real} [_y] The y position of the sprite. Defaults to 0.
/// @param {real} [_color] The color to blend the sprite with. Defaults
/// to `c_white`.
/// @param {real} [_alpha] The sprite alpha. Defaults to 1.
/// @return {CE_GUIWidget} The created widget.
function ce_gui_sprite_create(_sprite, _index=0, _x=0, _y=0, _color=c_white, _alpha=1)
{
	var _w = new CE_GUIWidget();
	_w.BackgroundSprite = _sprite;
	_w.BackgroundIndex = _index;
	_w.X = _x;
	_w.Y = _y;
	_w.BackgroundSpriteBlend = _color;
	_w.BackgroundSpriteAlpha = _alpha;
	_w.Width = sprite_get_width(_sprite);
	_w.Height = sprite_get_height(_sprite);
	return _w;
}