// Fixes returning from input on Android
var _focused = gui.WidgetFocused;
if (_focused != undefined)
{
	var _ev = new CE_GUIEvent(CE_EGuiEvent.KeyPress);
	_ev.Key = vk_enter;
	_focused.TriggerEvent(_ev);
	_ev.Destroy();
}