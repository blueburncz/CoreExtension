/// @var {real} The id of the GUI that is currently being rendered.
global.__ceGuiCurrent = noone;

/// @func ce_gui_root_create()
/// @desc Creates a new GUI root.
/// @return {real} The id of the created GUI root.
function ce_gui_root_create()
{
	var _root = ce_gui_container_create(CE_EGuiWidget.Root);

	_root[? "widgetHovered"] = noone;
	_root[? "widgetDragging"] = noone;
	_root[? "widgetFocused"] = noone;
	_root[? "eventBound"] = noone;
	_root[? "eventInstance"] = noone;
	_root[? "scale"] = 1;

	_root[? "mouseDragXLast"] = 0;
	_root[? "mouseDragYLast"] = 0;

	_root[? "widgetDraggable"] = noone;

	_root[? "fixPositioning"] = false;

	ds_map_add_list(_root, "destroyList", ds_list_create());

	return _root;
}

/// @func ce_gui_root_get_display_height(_root)
/// @param {real} _root The id of the GUI.
/// @return {real} The width of the display within the GUI.
function ce_gui_root_get_display_height(_root)
{
	gml_pragma("forceinline");
	return display_get_gui_height() / _root[? "scale"];
}

/// @func ce_gui_root_get_display_width(_root)
/// @param {real} _root The id of the GUI.
/// @return {real} The width of the display within the GUI.
function ce_gui_root_get_display_width(_root)
{
	gml_pragma("forceinline");
	return display_get_gui_width() / _root[? "scale"];
}

/// @func ce_gui_root_get_event(_root)
/// @param {real} _root The id of the gui.
/// @return {real} The id of the current event or `noone`.
/// @note This should only be used within the user event bound to
/// `CE_EEventBinding.Gui`.
function ce_gui_root_get_event(_root)
{
	gml_pragma("forceinline");
	return _root[? "eventInstance"];
}

/// @func ce_gui_root_get_focused_widget(_root)
/// @param {real} _root The id of the GUI.
/// @return {real} The id of the widget in focus or `noone`.
function ce_gui_root_get_focused_widget(_root)
{
	gml_pragma("forceinline");
	return _root[? "widgetFocused"];
}

/// @func ce_gui_root_get_hovered_widget(_root)
/// @param {real} _root The id of the GUI.
/// @return {real} The id of the hovered widget or `noone`.
function ce_gui_root_get_hovered_widget(_root)
{
	gml_pragma("forceinline");
	return _root[? "widgetHovered"];
}

/// @func ce_gui_root_is_typing(_root)
/// @param {real} _root The id of the gui.
function ce_gui_root_is_typing(_root)
{
	if (keyboard_virtual_status())
	{
		return true;
	}
	var _focused = ce_gui_root_get_focused_widget(_root);
	if (_focused != noone
		&& _focused[? "type"] == CE_EGuiWidget.Input)
	{
		return true;
	}
	return false;
}

/// @func ce_gui_root_get_mouse_x([_root])
/// @param {real} [_root] The id of the GUI. If not specified and a GUI is
/// currently being rendered, then argument defaults to it's id.
/// @return {real} The mouse x coordinate relative to the current render target.
function ce_gui_root_get_mouse_x()
{
	var _root = (argument_count > 0 ? argument[0] : global.__ceGuiCurrent);
	return _root[? "mouseX"];
}

/// @func ce_gui_root_get_mouse_y([_root])
/// @param {real} [_root] The id of the GUI. If not specified and a GUI is
/// currently being rendered, then argument defaults to it's id.
/// @return {real} The mouse y coordinate relative to the current render target.
function ce_gui_root_get_mouse_y()
{
	var _root = (argument_count > 0 ? argument[0] : global.__ceGuiCurrent);
	return _root[? "mouseY"];
}

/// @func ce_gui_root_set_current_font(_root, _font)
/// @param {real} _root The id of the GUI.
/// @param {real} _font The id of the font resource.
function ce_gui_root_set_current_font(_root, _font)
{
	if (_font == noone)
	{
		_font = ds_map_find_value(_root, "font");
	}
	if (_font != noone && draw_get_font() != _font)
	{
		draw_set_font(_font);
	}
}

/// @func ce_gui_root_set_focused_widget(_root, _widget)
/// @param {real} _root The id of the GUI.
/// @param {real} _widget The id of the widget. Use `noone` for none.
function ce_gui_root_set_focused_widget(_root, _widget)
{
	var _widgetPrev = _root[? "widgetFocused"];

	_root[? "widgetFocused"] = _widget;

	if (_widgetPrev != noone)
	{
		var _ev = ce_gui_event_create(CE_EGuiEvent.Blur);
		ce_gui_trigger_event(_widgetPrev, _ev);
		ce_gui_event_destroy(_ev);
	}

	if (_widget != noone)
	{
		var _ev = ce_gui_event_create(CE_EGuiEvent.Focus);
		ce_gui_trigger_event(_widget, _ev);
		ce_gui_event_destroy(_ev);
	}
}

/// @func ce_gui_root_mouse_over_gui(_root)
/// @param {real} _root The id of the GUI.
/// @return {bool} True if mouse is over some GUI element.
function ce_gui_root_mouse_over_gui(_root)
{
	gml_pragma("forceinline");
	return (ce_gui_root_get_hovered_widget(_root) != noone);
}

/// @func ce_gui_root_update(_root)
/// @param {real} _root The id of the GUI.
function ce_gui_root_update(_root)
{
	global.__ceGuiCurrent = _root;

	var _guiScale = _root[? "scale"];
	var _1ByGuiScale = 1 / _guiScale;

	var _guiWidth = display_get_gui_width();
	var _guiHeight = display_get_gui_height();

	var _guiWidthScaled = _guiWidth * _1ByGuiScale;
	var _guiHeightScaled = _guiHeight * _1ByGuiScale;

	ce_gui_widget_set_rectangle(_root, 0, 0, _guiWidthScaled, _guiHeightScaled);

	var _mouseXLinear = window_mouse_get_x() / window_get_width();
	var _mouseYLinear = window_mouse_get_y() / window_get_height();

	var _mouseX = _mouseXLinear * (_guiWidth / (CE_DESIGN_SCREEN_WIDTH * _guiScale)) * CE_DESIGN_SCREEN_WIDTH;
	var _mouseY = _mouseYLinear * (_guiHeight / (CE_DESIGN_SCREEN_HEIGHT * _guiScale)) * CE_DESIGN_SCREEN_HEIGHT;

	_root[? "mouseX"] = _mouseX;
	_root[? "mouseY"] = _mouseY;
	_root[? "widgetHovered"] = noone;
	_root[? "widgetDraggable"] = noone;

	ce_gui_widget_update_position(_root, _mouseX, _mouseY);
	while (_root[? "fixPositioning"])
	{
		_root[? "fixPositioning"] = false;
		ce_gui_widget_update_position(_root, _mouseX, _mouseY);
	}

	global.__ceGuiCurrent = noone;
}

/// @func ce_gui_root_draw(_root)
/// @desc Draws the GUI.
/// @param {real} _root The id of the GUI root.
function ce_gui_root_draw(_root)
{
	if (!_root[? "visible"])
	{
		return;
	}

	var _font = draw_get_font();

	global.__ceGuiCurrent = _root;
	ce_gui_container_draw(_root);

	#region Proxy input
	var _focused = ce_gui_root_get_focused_widget(argument0);

	if (_focused != noone
		&& _focused[? "type"] == CE_EGuiWidget.Input)
	{
		var _focusedInput = _focused;
		var _focusedInputX = _focusedInput[? "_xReal"];
		var _focusedInputY = _focusedInput[? "_yReal"];
		var _displayWidth = ce_gui_root_get_display_width(_root);
		var _displayHeight = ce_gui_root_get_display_height(_root);
		var _keyboardHeight = keyboard_virtual_height();

		if (rectangle_in_rectangle(_focusedInputX, _focusedInputY,
			_focusedInputX + _focusedInput[? "width"], _focusedInputY + _focusedInput[? "height"],
			0, 0, _displayWidth, _displayHeight - _keyboardHeight) == 0)
		{
			var _scrDrawProxy = _focusedInput[? "scrDrawProxy"];
			if (_scrDrawProxy != noone)
			{
				script_execute(_scrDrawProxy, _focusedInput);
			}
		}
	}
	#endregion Proxy input

	global.__ceGuiCurrent = noone;

	#region Destroy widgets
	var _destroyList = _root[? "destroyList"];

	for (var i = ds_list_size(_destroyList) - 1; i >= 0; --i)
	{
		var _widget = _destroyList[| i];
		if (!ce_gui_widget_exists(_widget))
		{
			continue;
		}
		#region Remove from parent
		var _parent = _widget[? "parent"];
		if (_parent != noone)
		{
			var _widgets = _parent[? "widgets"];
			var _idx = ds_list_find_index(_widgets, _widget);
			if (_idx != -1)
			{
				ds_list_delete(_widgets, _idx);
			}
		}
		#endregion Remove from parent
		ce_gui_widget_cleanup(_widget);
		ds_map_destroy(_widget);
	}
	ds_list_clear(_destroyList);
	#endregion Destroy widgets

	if (draw_get_font() != _font)
	{
		draw_set_font(_font);
	}
}

/// @func ce_gui_root_destroy(_root)
/// @desc Destroys the GUI root.
/// @param {real} _root The id of the GUI root.
function ce_gui_root_destroy(_root)
{
	ce_gui_container_cleanup(_root);
	ds_map_destroy(_root);
}