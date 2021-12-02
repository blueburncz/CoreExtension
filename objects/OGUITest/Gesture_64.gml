var _hovered = gui.WidgetHovered;

if (gui.WidgetFocused != _hovered)
{
	gui.SetFocusedWidget(_hovered);
}

if (_hovered != undefined)
{
	var _event = new CE_GUIClickEvent(mb_left);
	_hovered.TriggerEvent(_event);
	_event.Destroy();
}