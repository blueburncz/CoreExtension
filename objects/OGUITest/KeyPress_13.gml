// TODO: Fix GUI KeyPress event on mobile
var _focused = ce_gui_root_get_focused_widget(gui);
if (_focused != noone)
{
	var _ev = ce_gui_event_create(CE_EGuiEvent.KeyPress);
	_ev[? "key"] = vk_enter;
	ce_gui_trigger_event(_focused, _ev);
	ce_gui_event_destroy(_ev);
}