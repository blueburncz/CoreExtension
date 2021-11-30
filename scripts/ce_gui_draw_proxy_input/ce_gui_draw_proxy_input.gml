/// @funce ce_gui_draw_proxy_input(_focusedInput)
/// @desc The default script for drawing a proxy of an input.
/// @param {real} _focusedInput The id of the input widget.
function ce_gui_draw_proxy_input(_focusedInput)
{
	var _gui = _focusedInput[? "gui"];
	var _displayWidth = ce_gui_root_get_display_width(_gui);
	var _displayHeight = ce_gui_root_get_display_height(_gui);
	var _keyboardHeight = keyboard_virtual_height();

	// TODO: Set big font
	//ce_gui_root_set_current_font(_gui, global.fntRobotoMonoLarge);

	var _charWidth = string_width("Q");
	var _charHeight = string_height("Q");

	// Overlay
	ce_draw_rectangle(0, 0, _displayWidth, _displayHeight, c_black, 0.5);

	var _padding = 8;
	var _inputWidth = _displayWidth * 0.75;
	var _inputHeight = _charHeight + _padding * 2;
	var _inputX = floor((_displayWidth - _inputWidth) * 0.5);
	var _inputY = floor(((_displayHeight - _keyboardHeight) - _inputHeight) * 0.5);

	// Background
	ce_draw_rectangle(_inputX, _inputY, _inputWidth, _inputHeight, c_white, 1);

	var _charCount = floor((_inputWidth - _padding * 2) / _charWidth);
	var _text = keyboard_string;
	var _copyFrom = max(string_length(_text) - _charCount + 1, 1);
	_text = string_copy(_text, _copyFrom, _charCount);
	var _textX = _inputX + _padding;
	var _text_y = _inputY + _padding;

	// Text
	// TODO: Set big font
	ce_gui_draw_text(_gui, _textX, _text_y, _text, c_black, 1/*, global.fntRobotoMonoLarge*/);

	// Beam
	ce_draw_rectangle(_textX + string_width(_text), _text_y, 4, _charHeight, $FF8000, 1);
}
