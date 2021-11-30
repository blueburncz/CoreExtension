/// @func ce_gui_container_create([type])
/// @desc Creates a new container.
/// @param {CE_EGuiWidget} [type] The type of the container.
/// @return {real} id The id of the created container.
function ce_gui_container_create()
{
	var _container = ce_gui_widget_create((argument_count > 0) ? argument[0] : CE_EGuiWidget.Container);

	ds_map_add_list(_container, "widgets", ds_list_create());

	_container[? "sprite"] = noone;
	_container[? "subimage"] = 0;
	_container[? "scrDraw"] = ce_gui_container_draw;
	_container[? "scrCleanup"] = ce_gui_container_cleanup;

	_container[? "overflow"] = true;
	_container[? "surface"] = noone;
	_container[? "redraw"] = true;
	_container[? "contentStyle"] = CE_EGuiContentStyle.Default;
	_container[? "gridColumns"] = 1;
	_container[? "gridRows"] = 1;
	_container[? "contentW"] = 0;
	_container[? "contentH"] = 0;
	_container[? "scrollX"] = 0;
	_container[? "scrollY"] = 0;
	_container[? "scrollXEnable"] = false;
	_container[? "scrollYEnable"] = false;
	_container[? "grow"] = false;

	// Padding
	_container[? "paddingLeft"] = 0;
	_container[? "paddingTop"] = 0;
	_container[? "paddingRight"] = 0;
	_container[? "paddingBottom"] = 0;

	ce_gui_widget_add_event_listener(_container, CE_EGuiEvent.Drag, ce_gui_container_on_drag);

	return _container;
}

/// @func ce_gui_container_set_padding(_container, _left[, _top, _right, _bottom])
/// @desc Sets the margin of the container.
/// @param {real} _widget The id of the container.
/// @param {real} _left The left padding.
/// @param {real} [_top] The top padding. Defaults to the value of param `left`.
/// @param {real} [_right] The right padding. Defaults to the value of param `left`.
/// @param {real} [_bottom] The bottom padding. Defaults to the value of param `left`.
function ce_gui_container_set_padding(_container, _left)
{
	_container[? "paddingLeft"] = _left;

	if (argument_count == 2)
	{
		_container[? "paddingTop"] = _left;
		_container[? "paddingRight"] = _left;
		_container[? "paddingBottom"] = _left;
	}
	else
	{
		_container[? "paddingTop"] = argument[2];
		_container[? "paddingRight"] = argument[3];
		_container[? "paddingBottom"] = argument[4];
	}
}

/// @func ce_gui_container_add(_container, _widget)
/// @desc Adds the widget to the container.
/// @param {real} _container The id of the container.
/// @param {real} _widget The id of the widget.
function ce_gui_container_add(_container, _widget)
{
	ce_assert(_widget[? "gui"] == noone, "Widget is already added to a GUI.");
	ce_assert(_widget[? "parent"] == noone, "Widget already has a parent.");
	if (_container[? "type"] == CE_EGuiWidget.Root)
	{
		_widget[? "gui"] = _container;
	}
	else
	{
		var _parentGui = _container[? "gui"];
		ce_assert(_parentGui != noone, "Parent must be added to a GUI.");
		_widget[? "gui"] = _parentGui;
		_widget[? "parent"] = _container;
	}
	ce_ds_list_add_unique(_container[? "widgets"], _widget);
}

/// @func ce_gui_container_empty(_container)
/// @desc Destroys all child widgets of the container.
/// @param {real} _container The id of the container.
function ce_gui_container_empty(_container)
{
	var _widgets = _container[? "widgets"];
	var _index = 0;
	repeat (ds_list_size(_widgets))
	{
		ce_gui_widget_destroy(_widgets[| _index++]);
	}
}

/// @func ce_gui_container_on_drag(_container, _event)
/// @param {real} _container The id of the container.
/// @param {real} _event The id of the event.
function ce_gui_container_on_drag(_container, _event)
{
	var _redraw = false;

	if (_container[? "scrollXEnable"])
	{
		var _scrollXOld = _container[? "scrollX"];
		var _scrollX = clamp(_scrollXOld + _event[? "diffX"],
			0, max(_container[? "contentW"] - _container[? "width"], 0));
		if (_scrollX != _scrollXOld)
		{
			_container[? "scrollX"] = _scrollX;
			_redraw = true;
		}
	}

	if (_container[? "scrollYEnable"])
	{
		var _scrollYOld = _container[? "scrollY"];
		var _scrollY = clamp(_scrollYOld + _event[? "diffY"],
			0, max(_container[? "contentH"] - _container[? "height"], 0));
		if (_scrollY != _scrollYOld)
		{
			_container[? "scrollY"] = _scrollY;
			_redraw = true;
		}
	}

	if (_redraw)
	{
		_container[? "redraw"] = true;
	}
}

/// @func _ce_gui_container_draw_items(_container)
/// @param {real} _container The id of the container.
function _ce_gui_container_draw_items(_container)
{
	var _widgets = _container[? "widgets"];
	var _index = 0;
	repeat (ds_list_size(_widgets))
	{
		ce_gui_widget_draw(_widgets[| _index++]);
	}
}

/// @func ce_gui_container_draw(_container)
/// @desc Draws the container.
/// @param {real} _container The id of the container.
function ce_gui_container_draw(_container)
{
	var _x = _container[? "_xReal"];
	var _y = _container[? "_yReal"];
	var _width = _container[? "width"];
	var _height = _container[? "height"];
	var _overflow = _container[? "overflow"];
	var _redraw = _container[? "redraw"];

	if (!_overflow)
	{
		gpu_push_state();
		var _surfaceOld = _container[? "surface"];
		var _surface = ce_surface_check(_surfaceOld, _width, _height);
		if (_surface != _surfaceOld)
		{
			_container[? "surface"] = _surface;
			_redraw = true;
		}
		if (_redraw)
		{
			var _parent = _container[? "parent"];
			if (_parent != noone)
			{
				_parent[? "redraw"] = true;
			}
			_container[? "redraw"] = false;
			surface_set_target(_surface);
			draw_clear_alpha(0, 0);
			gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
			matrix_stack_push(matrix_get(matrix_world));
			matrix_set(matrix_world, matrix_build(-_x, -_y, 0, 0, 0, 0, 1, 1, 1));
			_ce_gui_widget_draw_background(_container, _x, _y, _width, _height);
			_ce_gui_container_draw_items(_container);
			matrix_set(matrix_world, matrix_stack_top());
			matrix_stack_pop();
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
		}
		gpu_pop_state();
		draw_surface(_surface, _x, _y);
	}
	else
	{
		_ce_gui_widget_draw_background(_container, _x, _y, _width, _height);
		_ce_gui_container_draw_items(_container);
	}
}

/// @func ce_gui_container_cleanup(_container)
/// @desc Frees additional resources used by the container from memory.
/// @param {real} _container The id of the container.
function ce_gui_container_cleanup(_container)
{
	var _widgets = _container[? "widgets"];
	var _index = 0;
	repeat (ds_list_size(_widgets))
	{
		ce_gui_widget_cleanup(_widgets[| _index++]);
	}
	var _surface = _container[? "surface"];
	if (_surface != noone)
	{
		surface_free(_surface);
	}
}