/// @func ce_gui_input_create(_value[, _x[, _y[, _width[, _height]]]])
/// @desc Creates a new input.
/// @param {any} value The initial value.
/// @param {real} [x] The x position. Defaults to 0.
/// @param {real} [y] The y position. Defaults to 0.
/// @param {real} [width] The width. Defaults to 256.
/// @param {real} [height] The height. Defaults to 64.
/// @return {real} The id of the created input.
function ce_gui_input_create(_value, _x=0, _y=0, _width=256, _height=64)
{
	var _input = ce_gui_widget_create(CE_EGuiWidget.Input);
	_input[? "value"] = _value;
	_input[? "length"] = noone;
	_input[? "_keyboardString"] = "";
	_input[? "x"] = _x;
	_input[? "y"] = _y;
	_input[? "width"] = _width;
	_input[? "height"] = _height;
	_input[? "backgroundColor"] = c_white;
	_input[? "backgroundAlpha"] = 1;
	_input[? "scrDraw"] = ce_gui_input_draw;
	_input[? "scrDrawProxy"] = ce_gui_draw_proxy_input;

	ce_gui_widget_add_event_listener(_input, CE_EGuiEvent.Focus, ce_gui_input_on_focus);
	ce_gui_widget_add_event_listener(_input, CE_EGuiEvent.Blur, ce_gui_input_on_blur);
	ce_gui_widget_add_event_listener(_input, CE_EGuiEvent.KeyPress, ce_gui_input_on_keypress);

	return _input;
}

/// @func ce_gui_input_on_blur(_input, _event)
/// @param {real} _input The id of the input.
/// @param {real} _event The id of the event.
function ce_gui_input_on_blur(_input, _event)
{
	var _valueOld = _input[? "value"];

	if (is_real(_valueOld))
	{
		if (keyboard_string != "")
		{
			_input[? "value"] = real(keyboard_string);
		}
	}
	else
	{
		_input[? "value"] = keyboard_string;
	}

	keyboard_string = _input[? "_keyboardString"];
	_input[? "_keyboardString"] = "";

	if (os_type == os_android)
	{
		keyboard_virtual_hide();
	}

	// TODO: Validate input value before change?

	if (_valueOld != _input[? "value"])
	{
		var _ev = ce_gui_event_create(CE_EGuiEvent.Change);
		ce_gui_trigger_event(_input, _ev);
		ce_gui_event_destroy(_ev);
	}
}

/// @func ce_gui_input_on_focus(_input, _event)
/// @param {real} _input The id of the input.
/// @param {real} _event The id of the event.
function ce_gui_input_on_focus(_input, _event)
{
	var _value = _input[? "value"];

	_input[? "_keyboardString"] = keyboard_string;
	keyboard_string = string(_value);

	if (os_type == os_android)
	{
		keyboard_virtual_show(
			is_real(_value) ? kbv_type_numbers : kbv_type_default,
			kbv_returnkey_default,
			kbv_autocapitalize_none,
			false);
	}
}

/// @func ce_gui_input_on_keypress(_input, _event)
/// @param {real} _input The id of the input.
/// @param {real} _event The id of the event.
function ce_gui_input_on_keypress(_input, _event)
{
	var _key = _event[? "key"];

	if (_key == vk_enter
		|| _key == vk_return)
	{
		ce_gui_root_set_focused_widget(_input[? "gui"], noone);
	}
}

/// @func ce_gui_input_draw(_input)
/// @desc Draws the input.
/// @param {real} _input The id of the input to draw.
function ce_gui_input_draw(_input)
{
	var _gui = _input[? "gui"];
	var _x = _input[? "_xReal"];
	var _y = _input[? "_yReal"];
	var _width = _input[? "width"];
	var _height = _input[? "height"];
	var _value = _input[? "value"];

	_ce_gui_widget_draw_background(_input, _x, _y, _width, _height);
	ce_gui_root_set_current_font(_gui, _input[? "font"]);

	var _padding = 16;
	var _charWidth = string_width("Q");
	var _charHeight = string_height("Q");
	var _textX = _x + _padding;
	var _text_y = _y + round((_height - _charHeight) * 0.5);
	var _color = c_black;
	var _charCount = floor((_width - _padding * 2) / _charWidth);
	var _focused = (ce_gui_root_get_focused_widget(_gui) == _input);
	var _text;

	if (_focused)
	{
		var _length = _input[? "length"];
		if (is_real(_value))
		{
			var _digits = string_digits(keyboard_string);
			if (keyboard_string != _digits)
			{
				keyboard_string = _digits;
			}
		}
		if (_length > 0 && string_length(keyboard_string) > _length)
		{
			keyboard_string = string_copy(keyboard_string, 1, _length);
		}
		_text = keyboard_string;
		var _copyFrom = max(string_length(_text) - _charCount + 1, 1);
		_text = string_copy(_text, _copyFrom, _charCount);
	}
	else
	{
		_text = string(_value);
		_text = string_copy(_text, 1, _charCount);
	}

	draw_text_color(_textX, _text_y, _text, _color, _color, _color, _color, 1);

	if (_focused)
	{
		ce_draw_rectangle(_textX + string_width(_text), _text_y, 4, _charHeight, $FF8000, 1);
	}
}