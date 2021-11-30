var _draggable = gui[? "widgetDraggable"];
if (_draggable != noone)
{
	gui[? "widgetDragging"] = _draggable;
	gui[? "mouseDragXLast"] = ce_gui_root_get_mouse_x(gui);
	gui[? "mouseDragYLast"] = ce_gui_root_get_mouse_y(gui);
	var _event = ce_gui_event_create(CE_EGuiEvent.DragStart);
	ce_gui_trigger_event(_draggable, _event);
	ce_gui_event_destroy(_event);
}