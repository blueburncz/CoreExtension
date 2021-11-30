/// @func ce_gui_event_create(_type)
/// @desc Creates a new GUI event.
/// @param {CE_EGuiEvent} _type The type of the event.
/// @return {real} The id of the created event.
function ce_gui_event_create(_type)
{
	var _event = ds_map_create();
	_event[? "type"] = _type;
	_event[? "target"] = noone;
	return _event;
}

/// @func ce_gui_event_get_type(_event)
/// @param {real} _event The id of the event.
/// @return {CE_EGuiEvent} The type of the event.
function ce_gui_event_get_type(_event)
{
	gml_pragma("forceinline");
	return _event[? "type"];
}

/// @func ce_gui_event_get_target(_event)
/// @param {real} _event The id of the event.
/// @return {real} The id of the widget that the event was triggered within or
/// `noone`.
function ce_gui_event_get_target(_event)
{
	gml_pragma("forceinline");
	return _event[? "target"];
}

/// @func ce_gui_event_destroy(_event)
/// @desc Destroys the event.
/// @param {real} _event The id of the event.
function ce_gui_event_destroy(_event)
{
	gml_pragma("forceinline");
	ds_map_destroy(_event);
}