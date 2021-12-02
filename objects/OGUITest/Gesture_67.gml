var _dragging = gui.WidgetDragging;
if (_dragging != undefined)
{
	var _mouseX = gui.MouseX;
	var _mouseY = gui.MouseY;
	var _event = new CE_GUIDragEvent(
		gui.MouseDragXLast - _mouseX,
		gui.MouseDragYLast - _mouseY);
	_dragging.TriggerEvent(_event);
	_event.Destroy();
	gui.MouseDragXLast = _mouseX;
	gui.MouseDragYLast = _mouseY;
}