/// @func ce_gui_text_create(_text[, _x[, _y[, _font[, _format]]]])
/// @desc Creates a new text widget.
/// @param {real} _text The text to draw.
/// @param {real} [_x] The x position of the sprite widget. Defaults to 0.
/// @param {real} [_y] The y position of the sprite widget. Defaults to 0.
/// @param {real} [_font] The id of the font resource to use. Use `noone`
/// (default) for the default font.
/// @param {bool} [_format] True to use `ce_string_format` when drawing
/// the text. Defaults to `false`.
/// @return {real} The id of the created text widget.
function ce_gui_text_create(_text, _x=0, _y=0, _font=noone, _format=false)
{
	var _textWidget = ce_gui_widget_create(CE_EGuiWidget.Text);
	_textWidget[? "text"] = _text;
	_textWidget[? "_textReal"] = "";
	_textWidget[? "x"] = _x;
	_textWidget[? "y"] = _y;
	_textWidget[? "font"] = _font;
	_textWidget[? "format"] = _format;
	_textWidget[? "scrDraw"] = ce_gui_text_draw;
	return _textWidget;
}

/// @func ce_gui_text_get_string(_textWidget)
/// @param {real} _textWidget The id of the text widget.
function ce_gui_text_get_string(_textWidget)
{
	gml_pragma("forceinline");
	return _textWidget[? "text"];
}

/// @func ce_gui_text_set_string(_textWidget, _string)
/// @param {real} _textWidget The id of the text widget.
/// @param {string} _string The new string.
function ce_gui_text_set_string(_textWidget, _string)
{
	gml_pragma("forceinline");
	_textWidget[? "text"] = _string;
}

/// @func ce_gui_text_draw(_textWidget)
/// @desc Draws the text widget.
/// @param {real} _textWidget The id of the text widget.
function ce_gui_text_draw(_textWidget)
{
	var _x = _textWidget[? "_xReal"];
	var _y = _textWidget[? "_yReal"];
	var _width = _textWidget[? "width"];
	var _height = _textWidget[? "height"];
	_ce_gui_widget_draw_background(_textWidget, _x, _y, _width, _height);
	ce_gui_draw_text(_textWidget[? "gui"], _x, _y, _textWidget[? "_textReal"], c_white, 1, _textWidget[? "font"]);
}