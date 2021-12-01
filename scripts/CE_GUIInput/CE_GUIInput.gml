/// @func ce_gui_input_create(_value[, _x[, _y[, _width[, _height]]]])
/// @extends CE_GUIWidget
/// @desc An input widget.
/// @param {any} value The initial value.
/// @param {real} [x] The x position. Defaults to 0.
/// @param {real} [y] The y position. Defaults to 0.
/// @param {real} [width] The width. Defaults to 256.
/// @param {real} [height] The height. Defaults to 32.
function CE_GUIInput(_value, _x=0, _y=0, _width=256, _height=64)
	: CE_GUIWidget(CE_EGuiWidget.Input) constructor
{
	CE_CLASS_GENERATED_BODY;

	Value = _value;
	Length = noone;
	_keyboardString = "";
	X = _x;
	Y = _y;
	Width = _width;
	Height = _height;
	BackgroundColor = c_white;
	BackgroundAlpha = 1;

	AddEventListener(CE_EGuiEvent.Focus, method(self, OnFocus));
	AddEventListener(CE_EGuiEvent.Blur, method(self, OnBlur));
	AddEventListener(CE_EGuiEvent.KeyPress, method(self, OnKeyPress));

	static OnFocus = function (_event) {
		var _value = Value;

		_keyboardString = keyboard_string;
		keyboard_string = string(_value);

		if (os_type == os_android)
		{
			keyboard_virtual_show(
				is_real(_value) ? kbv_type_numbers : kbv_type_default,
				kbv_returnkey_default,
				kbv_autocapitalize_none,
				false);
		}
	};

	static OnBlur = function (_event) {
		var _valueOld = Value;

		if (is_real(_valueOld))
		{
			if (keyboard_string != "")
			{
				Value = real(keyboard_string);
			}
		}
		else
		{
			Value = keyboard_string;
		}

		keyboard_string = _keyboardString;
		_keyboardString = "";

		if (os_type == os_android)
		{
			keyboard_virtual_hide();
		}

		// TODO: Validate input value before change?

		if (_valueOld != Value)
		{
			var _ev = new CE_GUIEvent(CE_EGuiEvent.Change);
			TriggerEvent(_ev);
			_ev.Destroy();
		}
	};

	static OnKeyPress = function (_event) {
		var _key = _event.Key;

		if (_key == vk_enter
			|| _key == vk_return)
		{
			Gui.SetFocusedWidget(noone);
		}

		var _current = self;
		while (_current != noone)
		{
			_current.Redraw = true;
			_current = _current.Parent;
		}
	};

	static OnDraw = function () {
		var _gui = Gui;
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;
		var _value = Value;

		DrawBackground(_x, _y, _width, _height);
		_gui.SetCurrentFont(Font);

		var _padding = 16;
		var _charWidth = string_width("Q");
		var _charHeight = string_height("Q");
		var _textX = _x + _padding;
		var _text_y = _y + round((_height - _charHeight) * 0.5);
		var _color = c_black;
		var _charCount = floor((_width - _padding * 2) / _charWidth);
		var _focused = (_gui.WidgetFocused == self);
		var _text;

		if (_focused)
		{
			var _length = Length;
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
	};

	static OnDrawProxy = function () {
		var _gui = Gui;
		var _displayWidth = _gui.GetDisplayWidth();
		var _displayHeight = _gui.GetDisplayHeight();
		var _keyboardHeight = keyboard_virtual_height() ?? 0;

		// TODO: Proxy input font configuration!
		_gui.SetCurrentFont(FntGUILarge);

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
		// TODO: Proxy input font configuration!
		ce_gui_draw_text(_gui, _textX, _text_y, _text, c_black, 1, FntGUILarge);

		// Beam
		ce_draw_rectangle(_textX + string_width(_text), _text_y, 4, _charHeight, $FF8000, 1);
	};
}