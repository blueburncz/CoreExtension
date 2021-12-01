/// @func ce_gui_text_create(_text[, _format[, _props]])
/// @extends CE_GUIWidget
/// @desc A text widget.
/// @param {real} _text The text to draw.
/// @param {bool} [_format] True to use `ce_string_format` when drawing
/// the text. Defaults to `false`.
/// @param {struct} [_props]
function CE_GUIText(_text, _format=false, _props={})
	: CE_GUIWidget(_props) constructor
{
	CE_CLASS_GENERATED_BODY;

	Text = _text;
	_textReal = "";
	Format = _format;
	Color = ce_struct_get(_props, "Color", c_white);
	Alpha = ce_struct_get(_props, "Color", 1.0);

	static OnDraw = function () {
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;
		DrawBackground(_x, _y, _width, _height);
		ce_gui_draw_text(Gui, _x, _y, _textReal, Color, Alpha, Font);
	};
}