/// @func ce_gui_widget_create([_type])
/// @desc Creates a new widget.
/// @param {CE_EGuiWidget} [_type] The type of the widget.
/// @return {real} The id of the created widget.
function ce_gui_widget_create(_type=CE_EGuiWidget.Widget)
{
	var _w = ds_map_create();
	_w[? "id"] = undefined;
	_w[? "type"] = _type;
	_w[? "x"] = 0;
	_w[? "y"] = 0;
	_w[? "width"] = 1;
	_w[? "height"] = 1;
	_w[? "scrDraw"] = ce_gui_widget_draw_default;
	_w[? "scrCleanup"] = noone;
	_w[? "gui"] = noone;
	_w[? "parent"] = noone;
	_w[? "events"] = noone;
	_w[? "font"] = noone;
	_w[? "visible"] = true;
	_w[? "position"] = CE_EGuiPosition.Scroll;

	// Pivot
	_w[? "pivotX"] = 0;
	_w[? "pivotY"] = 0;

	// Margin
	_w[? "marginLeft"] = 0;
	_w[? "marginTop"] = 0;
	_w[? "marginRight"] = 0;
	_w[? "marginBottom"] = 0;

	// Align within the parent widget
	_w[? "alignH"] = CE_EGuiAlign.Start;
	_w[? "alignV"] = CE_EGuiAlign.Start;

	// True calculated dimensions
	_w[? "_xReal"] = 0;
	_w[? "_yReal"] = 0;
	_w[? "_widthReal"] = 0;
	_w[? "_heightReal"] = 0;

	// Mouse coordinates relative to the widget position. Applicable only when
	// the widget is hovered/clicked/...
	_w[? "mouseX"] = 0;
	_w[? "mouseY"] = 0;

	// Background
	_w[? "backgroundColor"] = c_black;
	_w[? "backgroundAlpha"] = 0;
	_w[? "backgroundSprite"] = undefined;
	_w[? "backgroundIndex"] = 0;
	_w[? "backgroundStyle"] = CE_EGuiBackgroundStyle.Stretch;
	_w[? "backgroundSpriteBlend"] = c_white;
	_w[? "backgroundSpriteAlpha"] = 1;
	_w[? "backgroundTile"] = false; // Applies only to nine slice backgrounds.
	_w[? "backgroundAlignHor"] = 0;
	_w[? "backgroundAlignVer"] = 0;
	_w[? "backgroundWidth"] = undefined;
	_w[? "backgroundHeight"] = undefined;
	_w[? "backgroundScaleX"] = 1;
	_w[? "backgroundScaleY"] = 1;
	_w[? "backgroundX"] = 0;
	_w[? "backgroundY"] = 0;
	_w[? "backgroundRot"] = 0;

	return _w;
}

/// @func ce_gui_widget_exists(_widget)
/// @param {real} _widget The id of the widget.
/// @return {bool} True if the widget exists.
function ce_gui_widget_exists(_widget)
{
	gml_pragma("forceinline");
	return ds_exists(_widget, ds_type_map);
}

/// @func ce_gui_widget_set_margin(_widget, _left[, _top, _right, _bottom])
/// @desc Sets the margin of the widget.
/// @param {real} _widget The id of the widget.
/// @param {real} _left The left margin.
/// @param {real} [_top] The top margin. Defaults to the value of param `left`.
/// @param {real} [_right] The right margin. Defaults to the value of param `left`.
/// @param {real} [_bottom] The bottom margin. Defaults to the value of param `left`.
function ce_gui_widget_set_margin(_widget, _left)
{
	_widget[? "marginLeft"] = _left;

	if (argument_count == 2)
	{
		_widget[? "marginTop"] = _left;
		_widget[? "marginRight"] = _left;
		_widget[? "marginBottom"] = _left;
	}
	else
	{
		_widget[? "marginLeft"] = argument[1];
		_widget[? "marginTop"] = argument[2];
		_widget[? "marginRight"] = argument[3];
		_widget[? "marginBottom"] = argument[4];
	}
}

/// @func ce_gui_widget_add_event_listener(_widget, _eventType, _listener)
/// @desc TODO Write script description.
/// @param {real} _widget The id of the widget.
/// @param {CE_EGuiEvent} _eventType The event type.
/// @param {real} _listener An id of a script that will be executed when
/// the event occurs.
function ce_gui_widget_add_event_listener(_widget, _eventType, _listener)
{
	var _eventMap = _widget[? "events"];
	if (_eventMap == noone)
	{
		_eventMap = ds_map_create();
		ds_map_delete(_widget, "events"); // FIXME Maybe not necessary?
		ds_map_add_map(_widget, "events", _eventMap);
	}

	var _listeners;
	if (!ds_map_exists(_eventMap, _eventType))
	{
		_listeners = ds_list_create();
		ds_map_add_list(_eventMap, _eventType, _listeners);
	}
	else
	{
		_listeners = _eventMap[? _eventType];
	}

	ce_ds_list_add_unique(_listeners, _listener);
}

/// @func ce_gui_trigger_event(_widget, _event)
/// @desc TODO Write script desription.
/// @param {real} _widget The id of the widget.
/// @param {real} _event The id of the event.
function ce_gui_trigger_event(_widget, _event)
{
	_event[? "target"] = argument0;

	var _gui = _widget[? "gui"];

	_gui[? "eventInstance"] = _event;
	event_user(CE_EV_BIND_GUI);
	_gui[? "eventInstance"] = noone;

	var _eventMap = _widget[? "events"];
	if (!ds_exists(_eventMap, ds_type_map))
	{
		return;
	}

	var _event_type = ce_gui_event_get_type(_event);

	if (!ds_map_exists(_eventMap, _event_type))
	{
		return;
	}

	var _listeners = _eventMap[? _event_type];
	var _size = ds_list_size(_listeners);

	for (var i = 0; i < _size; ++i)
	{
		script_execute(_listeners[| i], _widget, _event);
	}
}

/// @func ce_gui_widget_find_hovered_widget(_widget, _mouseX, _mouseY)
/// @desc Recursively finds a widget underneath the mouse cursor.
/// @param {real} _widget The widget to start searching from.
/// @param {real} _mouseX The x position of the mouse cursor (relative to the
/// widget's position).
/// @param {real} _mouseY The y position of the mouse cursor (relative to the
/// widget's position).
/// @return {real} The id of the hovered widget or `noone`.
function ce_gui_widget_find_hovered_widget(_widget, _mouseX, _mouseY)
{
	if (!_widget[? "visible"])
	{
		return noone;
	}

	var _x = _widget[? "_xReal"];
	var _y = _widget[? "_yReal"];
	var _width = _widget[? "width"];
	var _height = _widget[? "height"];

	_widget[? "mouseX"] = _mouseX - _x;
	_widget[? "mouseY"] = _mouseY - _y;

	if (!ce_point_in_rect(_mouseX, _mouseY, _x, _y, _width, _height))
	{
		return noone;
	}

	_widget[? "redraw"] = true;

	if (!ds_map_exists(_widget, "widgets"))
	{
		return _widget;
	} 

	var _widgets = _widget[? "widgets"];
	for (var i = ds_list_size(_widgets) - 1; i >= 0; --i)
	{
		var _hovered = ce_gui_widget_find_hovered_widget(_widgets[| i], _mouseX - _x, _mouseY - _y);
		if (_hovered != noone)
		{
			return _hovered;
		}
	}

	return _widget;
}

/// @func ce_gui_widget_get_font(_widget)
/// @desc Gets the widget's font.
/// @param {real} _widget The id of the widget.
/// @return {real} The id of the font resource.
function ce_gui_widget_get_font(_widget)
{
	gml_pragma("forceinline");
	return _widget[? "font"];
}

/// @func ce_gui_widget_get_halign(_widget)
/// @desc Gets the horizontal align within the parent widget.
/// @param {real} _widget The id of the widget.
/// @return {real} The horizontal align.
function ce_gui_widget_get_halign(_widget)
{
	gml_pragma("forceinline");
	return _widget[? "alignH"];
}

/// @func ce_gui_widget_get_valign(_widget)
/// @desc Gets the vertical align within the parent widget.
/// @param {real} _widget The id of the widget.
/// @return {real} The vertical align.
function ce_gui_widget_get_valign(_widget)
{
	gml_pragma("forceinline");
	return _widget[? "alignV"];
}

/// @func ce_gui_widget_get_visible(_widget)
/// @param {real} _widget The id of the widget.
/// @return  {bool} True if the widget is visible.
function ce_gui_widget_get_visible(_widget)
{
	gml_pragma("forceinline");
	return _widget[? "visible"];
}

/// @func ce_gui_widget_is_mouse_over(_widget)
/// @param {real} _widget The id of the widget.
/// @return {bool} True if the mouse is over the widget.
function ce_gui_widget_is_mouse_over(_widget)
{
	gml_pragma("forceinline");
	return (global.__ceGuiCurrent[? "widgetHovered"] == _widget);
}

/// @func ce_gui_widget_set_font(_widget, _font)
/// @desc Sets the widget's font.
/// @param {real} _widget The id of the widget.
/// @param {real} _font The id of the font resource.
function ce_gui_widget_set_font(_widget, _font)
{
	gml_pragma("forceinline");
	_widget[? "font"] = _font;
}

/// @func ce_gui_widget_set_halign(_widget, _value)
/// @desc Sets the horizontal align within the parent widget.
/// @param {real} _widget The id of the widget.
/// @param {real} _value The new horizontal align. Use values in range 0..1.
function ce_gui_widget_set_halign(_widget, _value)
{
	_widget[? "alignH"] = _value;
}

/// @func ce_gui_widget_set_rectangle(_widget, _x, _y, _width, _height)
/// @desc Sets the position and the size of the widget to given values.
/// @param {real} _widget The id of the widget.
/// @param {real} _x The new x position of the widget.
/// @param {real} _y The new y position of the widget.
/// @param {real} _width The new width of the widget.
/// @param {real} _height The new height of the widget.
function ce_gui_widget_set_rectangle(_widget, _x, _y, _width, _height)
{
	_widget[? "x"] = _x;
	_widget[? "y"] = _y;
	_widget[? "width"] = _width;
	_widget[? "height"] = _height;
}

/// @func ce_gui_widget_set_valign(_widget, _value)
/// @desc Sets the vertical align within the parent widget.
/// @param {real} _widget The id of the widget.
/// @param {real} _value The new vertical align. Use values in range 0..1.
function ce_gui_widget_set_valign(_widget, _value)
{
	_widget[? "alignV"] = _value;
}

/// @func ce_gui_widget_set_visible(_widget, _visible)
/// @desc Shows / hides the widget based on the `visible` argument.
/// @param {real} _widget The id of the widget.
/// @param {bool} _visible False to hide the widget.
function ce_gui_widget_set_visible(_widget, _visible)
{
	gml_pragma("forceinline");
	_widget[? "visible"] = _visible;
}

/// @func ce_gui_widget_update_position(_widget, _mouseX, _mouseY)
/// @param {real} _widget The id of the widget.
/// @param {real} _mouseX The mouse x position relative to the widget.
/// @param {real} _mouseY The mouse y position relative to the widget.
function ce_gui_widget_update_position(_widget, _mouseX, _mouseY)
{
	if (!_widget[? "visible"])
	{
		return;
	}

	var _gui = _widget[? "gui"];
	var _x = _widget[? "_xReal"];
	var _y = _widget[? "_yReal"];
	var _width = _widget[? "width"];
	var _height = _widget[? "height"];

	if (_widget[? "type"] == CE_EGuiWidget.Text)
	{
		var _text = _widget[? "text"];
		if (_widget[? "format"])
		{
			_text = ce_string_format(_text);
		}
		ce_gui_root_set_current_font(_widget[? "gui"], _widget[? "font"]);
		var _widthNew = string_width(_text);
		var _heightNew = string_height(_text);
		if (_width != _widthNew
			|| _height != _heightNew)
		{
			_width = _widthNew;
			_height = _heightNew;
			_widget[? "width"] = _width;
			_widget[? "height"] = _height;
			_gui[? "fixPositioning"] = true;
		}
		_widget[? "_textReal"] = _text;
	}

	_widget[? "mouseX"] = _mouseX;
	_widget[? "mouseY"] = _mouseY;

	if (ce_gui_mouse_in_rect(_x, _y, _width, _height))
	{
		if (_gui != noone)
		{
			_gui[? "widgetHovered"] = _widget;
			var _eventMap = _widget[? "events"];
			if (ds_exists(_eventMap, ds_type_map)
				&& ds_map_exists(_eventMap, CE_EGuiEvent.Drag))
			{
				_gui[? "widgetDraggable"] = _widget;
			}
		}
		_widget[? "redraw"] = true;
	}

	if (!ds_map_exists(_widget, "widgets"))
	{
		return;
	}

	var _scrollX = ds_map_exists(_widget, "scrollX") ? _widget[? "scrollX"] : 0;
	var _scrollY = ds_map_exists(_widget, "scrollY") ? _widget[? "scrollY"] : 0;
	var _xScroll = _x - _scrollX;
	var _yScroll = _y - _scrollY;

	var _contentStyle = ds_map_exists(_widget, "contentStyle")
		? _widget[? "contentStyle"] : CE_EGuiContentStyle.Default;

	var _contentW = 0;
	var _contentH = 0;

	var _paddingLeft = _widget[? "paddingLeft"];
	var _paddingTop = _widget[? "paddingTop"];
	var _paddingRight = _widget[? "paddingRight"];
	var _paddingBottom = _widget[? "paddingBottom"];

	var _drawX = _paddingLeft;
	var _drawY = _paddingTop;
	var _stepX = 0;
	var _stepY = 0;

	if (_contentStyle == CE_EGuiContentStyle.Grid)
	{
		_stepX += (_width - _paddingRight - _paddingLeft) / _widget[? "gridColumns"];
		_stepY += (_height - _paddingBottom - _paddingTop) / _widget[? "gridRows"];
	}

	var _widgets = _widget[? "widgets"];
	var _widgetCount = ds_list_size(_widgets);

	for (var i = 0; i < _widgetCount; ++i)
	{
		var _w = _widgets[| i];

		if (!_widget[? "visible"])
		{
			continue;
		}

		var _wXReal = 0;
		var _wYReal = 0;
		var _position = ds_map_exists(_w, "position") ? _w[? "position"] : CE_EGuiPosition.Scroll;

		#region Position style
		switch (_position)
		{
		case CE_EGuiPosition.Scroll:
			var _wWidth = _w[? "width"];
			var _wHeight = _w[? "height"];
			var _xReal, _yReal;

			if (_contentStyle == CE_EGuiContentStyle.Grid)
			{
				_xReal = _drawX + _w[? "x"] + (_stepX - _wWidth) * _w[? "alignH"];
				_yReal = _drawY + _w[? "y"] + (_stepY - _wHeight) * _w[? "alignV"];
			}
			else
			{
				_drawX += _w[? "marginLeft"];
				_drawY += _w[? "marginTop"];
				_xReal = _drawX + _w[? "x"] + (_width - _wWidth) * _w[? "alignH"];
				_yReal = _drawY + _w[? "y"] + (_height - _wHeight) * _w[? "alignV"];
				_drawX += _w[? "marginRight"];
				_drawY += _w[? "marginBottom"];
			}

			_wXReal = _xScroll + _xReal;
			_wYReal = _yScroll + _yReal;

			#region Content style
			switch (_contentStyle)
			{
			case CE_EGuiContentStyle.Column:
				_drawY += _wHeight;
				_contentW = max(_xReal + _wWidth, _contentW);
				_contentH = max(_yReal + _wHeight, _contentH);
				break;

			case CE_EGuiContentStyle.Default:
				_contentW = max(_xReal + _wWidth, _contentW);
				_contentH = max(_yReal + _wHeight, _contentH);
				break;

			case CE_EGuiContentStyle.Grid:
				_drawX += _stepX;
				if (_drawX >= _width - _paddingRight)
				{
					_drawX = _paddingLeft;
					_drawY += _stepY;
				}
				_contentW = max(_drawX + _stepX, _contentW);
				_contentH = max(_drawY + _stepY, _contentH);
				break;

			case CE_EGuiContentStyle.Row:
				_drawX += _wWidth;
				_contentW = max(_xReal + _wWidth, _contentW);
				_contentH = max(_yReal + _wHeight, _contentH);
				break;
			}
			#endregion Content style
			break;

		case CE_EGuiPosition.Fixed:
			_wXReal = _x + _w[? "x"] + (_width - _w[? "width"]) * _w[? "alignH"];
			_wYReal = _y + _w[? "y"] + (_height - _w[? "height"]) * _w[? "alignV"];
			break;

		default:
			ce_assert(false, "Unknown widget position property");
		}
		#endregion Position style

		_w[? "_xReal"] = _wXReal;
		_w[? "_yReal"] = _wYReal;

		ce_gui_widget_update_position(_w, _mouseX + _x - _wXReal, _mouseY + _y - _wYReal);
	}

	_contentW += _paddingRight;
	_contentH += _paddingBottom;

	_widget[? "contentW"] = _contentW;
	_widget[? "contentH"] = _contentH;

	if (_widget[? "grow"]
		&& (_width != _contentW
		|| _height != _contentH))
	{
		_widget[? "width"] = _contentW;
		_widget[? "height"] = _contentH;
		if (_gui != noone)
		{
			_gui[? "fixPositioning"] = true;
		}
	}
}

/// @func _ce_gui_widget_draw_background(_widget, _x, _y, _width, _height)
/// @param {real} _widget The id of the widget.
/// @param {real} _x The x position of the background.
/// @param {real} _y The y position of the background.
/// @param {real} _width The width of the background.
/// @param {real} _height The height of the background.
function _ce_gui_widget_draw_background(_widget, _x, _y, _width, _height)
{
	#region Background color
	var _backgroundAlpha = _widget[? "backgroundAlpha"];
	if (_backgroundAlpha > 0)
	{
		ce_draw_rectangle(_x, _y, _width, _height, _widget[? "backgroundColor"], _backgroundAlpha);
	}
	#endregion Background color

	#region Background sprite
	var _backgroundSprite = _widget[? "backgroundSprite"];
	if (!is_undefined(_backgroundSprite))
	{
		var _backgroundIndex = _widget[? "backgroundIndex"];
		var _backgroundX = _x + _widget[? "backgroundX"];
		var _backgroundY = _y + _widget[? "backgroundY"];
		var _backgroundWidth = _widget[? "backgroundWidth"];
		var _backgroundHeight = _widget[? "backgroundHeight"];
		var _backgroundSpriteBlend = _widget[? "backgroundSpriteBlend"];
		var _backgroundSpriteAlpha = _widget[? "backgroundSpriteAlpha"];
		var _backgroundAlignHor = _widget[? "backgroundAlignHor"];
		var _backgroundAlignVer = _widget[? "backgroundAlignVer"];

		switch (_widget[? "backgroundStyle"])
		{
		case CE_EGuiBackgroundStyle.Scale:
			var _backgroundScaleX = _widget[? "backgroundScaleX"];
			var _backgroundScaleY = _widget[? "backgroundScaleY"];

			_backgroundWidth = is_undefined(_backgroundWidth)
				? _width : (sprite_get_width(_backgroundSprite) * _backgroundScaleX);
			_backgroundHeight = is_undefined(_backgroundHeight)
				? _height : (sprite_get_height(_backgroundSprite) * _backgroundScaleY);

			if (_backgroundAlignHor != 0)
			{
				_backgroundX += (_width - _backgroundWidth) * _backgroundAlignHor;
			}
			if (_backgroundAlignVer != 0)
			{
				_backgroundY += (_height - _backgroundHeight) * _backgroundAlignVer;
			}

			draw_sprite_ext(_backgroundSprite, _backgroundIndex, _backgroundX, _backgroundY,
				_backgroundScaleX, _backgroundScaleY, _widget[? "backgroundRot"], _backgroundSpriteBlend,
				_backgroundSpriteAlpha);
			break;

		case CE_EGuiBackgroundStyle.Stretch:
			_backgroundWidth = is_undefined(_backgroundWidth) ? _width : _backgroundWidth;
			_backgroundHeight = is_undefined(_backgroundHeight) ? _height : _backgroundHeight;

			if (_backgroundAlignHor != 0)
			{
				_backgroundX += (_width - _backgroundWidth) * _backgroundAlignHor;
			}
			if (_backgroundAlignVer != 0)
			{
				_backgroundY += (_height - _backgroundHeight) * _backgroundAlignVer;
			}

			draw_sprite_stretched_ext(_backgroundSprite, _backgroundIndex,
				_backgroundX, _backgroundY, _width, _height, _backgroundSpriteBlend,
				_backgroundSpriteAlpha);
			break;

		case CE_EGuiBackgroundStyle.NineSlice:
			_backgroundWidth = is_undefined(_backgroundWidth) ? _width : _backgroundWidth;
			_backgroundHeight = is_undefined(_backgroundHeight) ? _height : _backgroundHeight;

			if (_backgroundAlignHor != 0)
			{
				_backgroundX += (_width - _backgroundWidth) * _backgroundAlignHor;
			}
			if (_backgroundAlignVer != 0)
			{
				_backgroundY += (_height - _backgroundHeight) * _backgroundAlignVer;
			}

			// TODO: Add ce_draw_sprite_nine_slice
			//ce_draw_sprite_nine_slice(_backgroundSprite, _backgroundIndex,
			//	_backgroundX, _backgroundY, _width, _height, _widget[? "backgroundTile"],
			//	_backgroundSpriteBlend, _backgroundSpriteAlpha);
			break;
		}
	}
	#endregion Background sprite
}

/// @func ce_gui_widget_draw(_widget)
/// @desc Draws the widget.
/// @param {real} _widget The id of the widget.
function ce_gui_widget_draw(_widget)
{
	if (!_widget[? "visible"])
	{
		return;
	}

	var _scr = _widget[? "scrDraw"];
	if (_scr != noone)
	{
		script_execute(_scr, _widget);
	}
}

/// @func ce_gui_widget_draw_default(_widget)
/// @param {real} _widget The id of the widget.
function ce_gui_widget_draw_default(_widget)
{
	_ce_gui_widget_draw_background(_widget,
		_widget[? "_xReal"],
		_widget[? "_yReal"],
		_widget[? "width"],
		_widget[? "height"]);
}

/// @func ce_gui_widget_cleanup(_widget)
/// @desc Frees additional resources used by the widget from memory.
/// @param {real} _widget The id of the widget.
function ce_gui_widget_cleanup(_widget)
{
	var _scr = _widget[? "scrCleanup"];
	if (_scr != noone)
	{
		script_execute(_scr, _widget);
	}
}

/// @func ce_gui_widget_destroy(_widget)
/// @desc Adds the widget to the list of widgets to be destroyed at the end of
/// the frame.
/// @param {real} _widget The id of the widget.
function ce_gui_widget_destroy(_widget)
{
	var _gui = _widget[? "gui"];
	ce_gui_widget_set_visible(_widget, false);
	ds_list_add(_gui[? "destroyList"], _widget);
}