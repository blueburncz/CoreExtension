var _focused = gui.WidgetFocused;
if (_focused != noone)
{
	var _ev = new CE_GUIEvent(CE_EGuiEvent.KeyPress);
	_ev.Key = keyboard_key;
	_focused.TriggerEvent(_ev);
	_ev.Destroy();
}