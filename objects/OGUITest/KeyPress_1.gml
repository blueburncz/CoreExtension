var _focused = gui.WidgetFocused;
if (_focused != undefined)
{
	var _ev = new CE_GUIKeyPressEvent(keyboard_key);
	_focused.TriggerEvent(_ev);
	_ev.Destroy();
}