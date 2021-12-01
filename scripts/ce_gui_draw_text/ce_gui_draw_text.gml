/// @func ce_gui_draw_text(_gui, _x, _y, _string[, _color[, _alpha[, _font]]])
/// @desc Draws text at given position.
/// @param {real} _gui The id of the GUI.
/// @param {real} _x The x position to draw the text at.
/// @param {real} _y The y position to draw the text at.
/// @param {string} _string The text to draw.
/// @param {real} [_color] The color of the text.
/// @param {real} [_alpha] The alpha of the text.
/// @param {real} [_font] The id of the font resource to use. Use `noone` for the
/// default font.
function ce_gui_draw_text(_gui, _x, _y, _string)
{
	_gui.SetCurrentFont((argument_count > 6) ? argument[6] : noone);
	var _color = (argument_count > 4) ? argument[4] : draw_get_color();
	draw_text_color(_x, _y, _string,
		_color, _color, _color, _color,
		(argument_count > 5) ? argument[5] : 1);
}