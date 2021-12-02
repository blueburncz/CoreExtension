/// @func CE_GUIHSlider(_min, _max, _value[, _integers[, _props]])
/// @extends CE_GUIWidget
/// @param {real} _min Minimum value.
/// @param {real} _max Maximum value.
/// @param {real} _value The current value.
/// @param {bool} [_integers] True if the values can be integers only. Defaults
/// to `false`.
/// @param {struct} [_props]
function CE_GUIHSlider(_min, _max, _value, _integers=false, _props={})
	: CE_GUIWidget(_props) constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {real}
	/// @readonly
	Min = _min;

	/// @var {real}
	/// @readonly
	Max = _max;

	/// @var {real}
	/// @readonly
	Value = _value;

	/// @var {bool}
	/// @readonly
	Integers = _integers;

	Width = ce_struct_get(_props, "Width", 256);
	Height = ce_struct_get(_props, "Height", 24);

	var _onDrag = method(self, OnDrag);
	AddEventListener(CE_GUIClickEvent, _onDrag);
	AddEventListener(CE_GUIDragEvent, _onDrag);
	AddEventListener(CE_GUIDragStartEvent, _onDrag);

	static OnDrag = function (_event) {
		_event.Propagate = false;

		var _width = Width;
		var _min = Min;
		var _max = Max;
		var _valueOld = Value;
		var _value = lerp(_min, _max, clamp(MouseX / _width, 0, 1));
		_value = (Integers) ? round(_value) : _value;

		if (_value != _valueOld)
		{
			Value = _value;
			var _eventChange = new CE_GUIChangeEvent(_valueOld);
			TriggerEvent(_eventChange);
			_eventChange.Destroy();
		}
	};

	static OnDraw = function () {
		var _x = RealX;
		var _y = RealY;
		var _width = Width;
		var _height = Height;
		var _min = Min;
		var _max = Max;
		var _val = Value;
		var _mul = (_val - _min) / (_max - _min);

		ce_draw_rectangle(_x, _y, _width, _height, $101010);
		ce_draw_rectangle(_x, _y, _width * _mul, _height, $FF8000);
	};
}