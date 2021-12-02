var _dragging = gui.WidgetDragging;
if (_dragging != undefined)
{
	var _event = new CE_GUIDragEndEvent();
	_dragging.TriggerEvent(_event);
	_event.Destroy();
	gui.WidgetDragging = noone;
}