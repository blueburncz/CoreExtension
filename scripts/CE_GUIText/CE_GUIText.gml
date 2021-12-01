/// @func ce_gui_text_create(_text[, _x[, _y[, _font[, _format]]]])
/// @extends CE_GUIWidget
/// @desc A text widget.
/// @param {real} _text The text to draw.
/// @param {real} [_x] The x position of the sprite widget. Defaults to 0.
/// @param {real} [_y] The y position of the sprite widget. Defaults to 0.
/// @param {real} [_font] The id of the font resource to use. Use `noone`
/// (default) for the default font.
/// @param {bool} [_format] True to use `ce_string_format` when drawing
/// the text. Defaults to `false`.
function CE_GUIText(_text, _x=0, _y=0, _font=noone, _format=false)
	: CE_GUIWidget() constructor
{
	CE_CLASS_GENERATED_BODY;

	Text = _text;
	Color = c_white;
	Alpha = 1.0;
	_textReal = "";
	X = _x;
	Y = _y;
	Font = _font;
	Format = _format;

	static OnDraw = function () {
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;
		DrawBackground(_x, _y, _width, _height);
		ce_gui_draw_text(Gui, _x, _y, _textReal, Color, Alpha, Font);
	};
}