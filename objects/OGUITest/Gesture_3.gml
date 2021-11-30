var _dragging = gui[? "widgetDragging"];
if (_dragging != noone)
{
	var _mouseX = ce_gui_root_get_mouse_x(gui);
	var _mouseY = ce_gui_root_get_mouse_y(gui);
	var _event = ce_gui_event_create(CE_EGuiEvent.Drag);
	_event[? "diffX"] = gui[? "mouseDragXLast"] - _mouseX;
	_event[? "diffY"] = gui[? "mouseDragYLast"] - _mouseY;
	ce_gui_trigger_event(_dragging, _event);
	ce_gui_event_destroy(_event);
	gui[? "mouseDragXLast"] = _mouseX;
	gui[? "mouseDragYLast"] = _mouseY;
}