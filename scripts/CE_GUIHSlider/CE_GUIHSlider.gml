/// @func CE_GUIHSlider(_min, _max, _value[, _integers[, _x[, _y]]])
/// @extends CE_GUIWidget
/// @param {real} _min Minimum value.
/// @param {real} _max Maximum value.
/// @param {real} _value The current value.
/// @param {bool} [_integers] True if the values can be integers only. Defaults
/// to `false`.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
function CE_GUIHSlider(_min, _max, _value, _integers=false, _x=0, _y=0)
	: CE_GUIWidget() constructor
{
	CE_CLASS_GENERATED_BODY;

	Min = _min;
	Max = _max;
	Value = _value;
	Integers = _integers;
	X = _x;
	Y = _y;

	var _onDrag = method(self, OnDrag);
	AddEventListener(CE_EGuiEvent.Click, _onDrag);
	AddEventListener(CE_EGuiEvent.Drag, _onDrag);
	AddEventListener(CE_EGuiEvent.DragStart, _onDrag);

	static OnDrag = function (_event) {
		var _width = Width;
		var _min = Min;
		var _max = Max;
		var _valueOld = Value;
		var _value = lerp(_min, _max, clamp(MouseX / _width, 0, 1));
		_value = (Integers) ? round(_value) : _value;

		if (_value != _valueOld)
		{
			Value = _value;
			var _eventChanged = new CE_GUIEvent(CE_EGuiEvent.Change);
			TriggerEvent(_eventChanged);
			_eventChanged.Destroy();
		}
	};

	static OnDraw = function () {
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;
		var _min = Min;
		var _max = Max;
		var _val = Value;
		var _mul = (_val - _min) / (_max - _min);

		ce_draw_rectangle(_x, _y, _width, _height, $101010);
		ce_draw_rectangle(_x, _y, _width * _mul, _height, $70FF00);
	};
}