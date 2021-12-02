var _draggable = gui.WidgetDraggable;
if (_draggable != undefined)
{
	if (gui.WidgetFocused != undefined)
	{
		gui.SetFocusedWidget(undefined);
	}

	gui.WidgetDragging = _draggable;
	gui.MouseDragXLast = gui.MouseX;
	gui.MouseDragYLast = gui.MouseY;
	var _event = new CE_GUIDragStartEvent();
	_draggable.TriggerEvent(_event);
	_event.Destroy();
}