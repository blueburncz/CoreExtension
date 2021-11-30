/// @func ce_gui_hslider_create(_min, _max, _value[, _integers[, _x[, _y]]])
/// @param {real} _min Minimum value.
/// @param {real} _max Maximum value.
/// @param {real} _value The current value.
/// @param {bool} [_integers] True if the values can be integers only. Defaults
/// to `false`.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
function ce_gui_hslider_create(_min, _max, _value, _integers=false, _x=0, _y=0)
{
	var _hslider = ce_gui_widget_create(CE_EGuiWidget.HSlider);
	_hslider[? "min"] = _min;
	_hslider[? "max"] = _max;
	_hslider[? "value"] = _value;
	_hslider[? "integers"] = _integers;
	_hslider[? "x"] = _x;
	_hslider[? "y"] = _y;
	_hslider[? "scrDraw"] = ce_gui_hslider_draw;
	ce_gui_widget_add_event_listener(_hslider, CE_EGuiEvent.Click, ce_gui_hslider_on_drag);
	ce_gui_widget_add_event_listener(_hslider, CE_EGuiEvent.Drag, ce_gui_hslider_on_drag);
	ce_gui_widget_add_event_listener(_hslider, CE_EGuiEvent.DragStart, ce_gui_hslider_on_drag);
	return _hslider;
}

/// @func ce_gui_hslider_on_drag(_hslider, _event)
/// @param {real} _hslider The id of the horizontal slider.
/// @param {real} _event The id of the event.
function ce_gui_hslider_on_drag(_hslider, _event)
{
	var _width = _hslider[? "width"];
	var _min = _hslider[? "min"];
	var _max = _hslider[? "max"];
	var _valueOld = _hslider[? "value"];
	var _value = lerp(_min, _max, clamp(ce_gui_root_get_mouse_x(_hslider) / _width, 0, 1));
	_value = (_hslider[? "integers"]) ? round(_value) : _value;

	if (_value != _valueOld)
	{
		_hslider[? "value"] = _value;
		var _eventChanged = ce_gui_event_create(CE_EGuiEvent.Change);
		ce_gui_trigger_event(_hslider, _eventChanged);
		ce_gui_event_destroy(_eventChanged);
	}
}

/// @func ce_gui_hslider_draw(_hslider)
/// @param {real} _hslider The id of the horizontal slider.
function ce_gui_hslider_draw(_hslider)
{
	var _x = _hslider[? "_xReal"];
	var _y = _hslider[? "_yReal"];
	var _width = _hslider[? "width"];
	var _height = _hslider[? "height"];
	var _min = _hslider[? "min"];
	var _max = _hslider[? "max"];
	var _val = _hslider[? "value"];
	var _mul = (_val - _min) / (_max - _min);

	ce_draw_rectangle(_x, _y, _width, _height, $101010);
	ce_draw_rectangle(_x, _y, _width * _mul, _height, $70FF00);
}