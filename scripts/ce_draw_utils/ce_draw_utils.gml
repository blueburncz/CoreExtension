/// @func ce_draw_rectangle(_x, _y, _width, _height[, _color[, _alpha]])
/// @desc Draws a rectangle of the given size and color at the given position.
/// @param {real} _x The x position to draw the rectangle at.
/// @param {real} _y The y position to draw the rectangle at.
/// @param {real} _width The width of the rectangle.
/// @param {real} _height The height of the rectangle.
/// @param {uint} [_color] The color of the rectangle. Defaults to `c_white`.
/// @param {real} [_alpha] The alpha of the rectangle. Defaults to 1.
function ce_draw_rectangle(_x, _y, _width, _height)
{
	gml_pragma("forceinline");
	draw_sprite_ext(CE_SprRectangle, 0, _x, _y, _width, _height, 0,
		(argument_count > 4) ? argument[4] : c_white,
		(argument_count > 5) ? argument[5] : 1);
}

/// @func ce_draw_text_shadow(_x, _y, _string[, _color[, _shadow]])
/// @desc Draws a text with a shadow.
/// @param {real} _x The x position to draw the text at.
/// @param {real} _y The y position to draw the text at.
/// @param {string} _string The text to draw.
/// @param {uint} [_color] The color of the text. Defaults to `c_white`.
/// @param {uint} [_shadow] The color of the shadow. Defaults to `c_black`.
function ce_draw_text_shadow(_x, _y, _string)
{
	var _color = (argument_count > 3) ? argument[3] : c_white;
	var _shadow = (argument_count > 4) ? argument[4] : c_black;
	draw_text_color(_x + 1, _y + 1, _string, _shadow, _shadow, _shadow, _shadow, 1);
	draw_text_color(_x, _y, _string, _color, _color, _color, _color, 1);
}