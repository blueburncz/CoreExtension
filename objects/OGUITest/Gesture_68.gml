var _dragging = gui.WidgetDragging;
if (_dragging != undefined)
{
	var _event = new CE_GUIEvent(CE_EGuiEvent.DragEnd);
	_dragging.TriggerEvent(_event);
	_event.Destroy();
	gui.WidgetDragging = noone;
}