var _hovered = ce_gui_root_get_hovered_widget(gui);

if (ce_gui_root_get_focused_widget(gui) != _hovered)
{
	ce_gui_root_set_focused_widget(gui, _hovered);
}

if (_hovered != noone)
{
	var _event = ce_gui_event_create(CE_EGuiEvent.Click);
	ce_gui_trigger_event(_hovered, _event);
	ce_gui_event_destroy(_event);
}