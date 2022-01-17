/// @func CE_GUIInput(_value[, _decimalPlaces[, _props]])
/// @extends CE_GUIWidget
/// @desc An input widget.
/// @param {any} _value The initial value.
/// @param {uint} [_decimalPlaces] Number of decimal places. Defaults to 2.
/// @param {struct} [_props]
function CE_GUIInput(_value, _decimalPlaces=2, _props={})
	: CE_GUIWidget(_props) constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {real/string}
	/// @readonly
	Value = _value;

	/// @var {uint}
	/// @readonly
	DecimalPlaces = _decimalPlaces;

	/// @var {uint/undefined} Limit number of characters.
	Length = undefined;

	/// @var {string} Backup of the keyboard string.
	/// @private
	KeyboardString = "";

	Width = ce_struct_get(_props, "Width", 256);
	BackgroundColor = ce_struct_get(_props, "BackgroundColor", c_white);
	BackgroundAlpha = ce_struct_get(_props, "BackgroundAlpha", 1);

	PaddingLeft = ce_struct_get(_props, "PaddingLeft", 16);
	PaddingRight = ce_struct_get(_props, "PaddingRight", 16);
	PaddingTop = ce_struct_get(_props, "PaddingTop", 8);
	PaddingBottom = ce_struct_get(_props, "PaddingBottom", 8);

	AddEventListener(CE_GUIFocusEvent, method(self, OnFocus));
	AddEventListener(CE_GUIBlurEvent, method(self, OnBlur));
	AddEventListener(CE_GUIKeyDownEvent, method(self, OnKeyDown));
	AddEventListener(CE_GUIKeyPressEvent, method(self, OnKeyPress));

	static OnFocus = function (_event) {
		var _value = Value;

		KeyboardString = keyboard_string;
		keyboard_string = is_real(_value)
			? ce_real_to_string(_value, DecimalPlaces)
			: _value;

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
			var _real = ce_parse_real(keyboard_string);
			if (!is_nan(_real))
			{
				Value = _real;
			}
		}
		else
		{
			Value = keyboard_string;
		}

		keyboard_string = KeyboardString;
		KeyboardString = "";

		if (os_type == os_android)
		{
			keyboard_virtual_hide();
		}

		// TODO: Validate input value before change?

		if (_valueOld != Value)
		{
			var _ev = new CE_GUIChangeEvent(_valueOld);
			TriggerEvent(_ev);
			_ev.Destroy();
		}
	};

	static OnKeyDown = function (_event) {
		RequestRedraw();
	};

	static OnKeyPress = function (_event) {
		var _key = _event.Key;
		if (_key == vk_enter
			|| _key == vk_return)
		{
			Root.SetFocusedWidget(undefined);
		}
		RequestRedraw();
	};

	static OnDraw = function () {
		var _root = Root;
		_root.SetCurrentFont(Font);
		var _charWidth = string_width("Q");
		var _charHeight = string_height("Q");

		var _x = RealX;
		var _y = RealY;
		var _width = RealWidth;
		var _height = PaddingTop + _charHeight + PaddingBottom;
		RealHeight = _height;

		var _textX = _x + PaddingLeft;
		var _textY = _y + PaddingTop;
		var _value = Value;

		DrawBackground();

		var _color = c_black;
		var _charCount = floor((_width - PaddingLeft - PaddingRight) / _charWidth);
		var _focused = (_root.WidgetFocused == self);
		var _text;

		if (_focused)
		{
			var _length = Length;
			//if (is_real(_value))
			//{
			//	var _digits = string_digits(keyboard_string);
			//	if (keyboard_string != _digits)
			//	{
			//		keyboard_string = _digits;
			//	}
			//}
			if (_length != undefined
				&& _length > 0
				&& string_length(keyboard_string) > _length)
			{
				keyboard_string = string_copy(keyboard_string, 1, _length);
			}
			_text = keyboard_string;
			var _copyFrom = max(string_length(_text) - _charCount + 1, 1);
			_text = string_copy(_text, _copyFrom, _charCount);
		}
		else
		{
			_text = is_real(_value)
				? ce_real_to_string(_value, DecimalPlaces)
				: _value;
			_text = string_copy(_text, 1, _charCount);
		}

		draw_text_color(_textX, _textY, _text, _color, _color, _color, _color, 1);

		if (_focused)
		{
			ce_draw_rectangle(_textX + string_width(_text), _textY, 4, _charHeight, $FF8000, 1);
		}
	};

	static OnDrawProxy = function () {
		var _root = Root;
		var _displayWidth = _root.GetDisplayWidth();
		var _displayHeight = _root.GetDisplayHeight();
		var _keyboardHeight = keyboard_virtual_height() ?? 0;

		// TODO: Proxy input font configuration!
		_root.SetCurrentFont(FntGUILarge);

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
		var _textY = _inputY + _padding;

		// Text
		draw_text_color(_textX, _textY, _text, c_black, c_black, c_black, c_black, 1);

		// Beam
		ce_draw_rectangle(_textX + string_width(_text), _textY, 4, _charHeight, $FF8000, 1);
	};
}