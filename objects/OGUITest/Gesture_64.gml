var _hovered = gui.WidgetHovered;

if (gui.WidgetFocused != _hovered)
{
	gui.SetFocusedWidget(_hovered);
}

if (_hovered != undefined)
{
	var _event = new CE_GUIEvent(CE_EGuiEvent.Click);
	_hovered.TriggerEvent(_event);
	_event.Destroy();
}