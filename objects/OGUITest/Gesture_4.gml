var _dragging = gui[? "widgetDragging"];
if (_dragging != noone)
{
	var _event = ce_gui_event_create(CE_EGuiEvent.DragEnd);
	ce_gui_trigger_event(_dragging, _event);
	ce_gui_event_destroy(_event);
	gui[? "widgetDragging"] = noone;
}