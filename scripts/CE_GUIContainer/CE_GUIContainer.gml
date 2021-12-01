/// @func CE_GUIContainer([_type])
/// @extends CE_GUIWidget
/// @desc A container of widgets.
/// @param {CE_EGuiWidget} [_type] The type of the container.
function CE_GUIContainer(_type=CE_EGuiWidget.Container)
	: CE_GUIWidget(_type) constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Widget = {
		OnCleanUp: OnCleanUp,
	};

	Widgets = ds_list_create();

	Sprite = noone;
	Subimage = 0;

	Overflow = true;
	Surface = noone;
	Redraw = true;
	ContentStyle = CE_EGuiContentStyle.Default;
	GridColumns = 1;
	GridRows = 1;
	ContentW = 0;
	ContentH = 0;
	ScrollX = 0;
	ScrollY = 0;
	ScrollXEnable = false;
	ScrollYEnable = false;
	Grow = false;

	// Padding
	PaddingLeft = 0;
	PaddingTop = 0;
	PaddingRight = 0;
	PaddingBottom = 0;

	AddEventListener(CE_EGuiEvent.Drag, method(self, OnDrag));

	/// @func SetPadding(_left[, _top, _right, _bottom])
	/// @desc Sets the margin of the container.
	/// @param {real} _left The left padding.
	/// @param {real} [_top] The top padding. Defaults to the value of param `left`.
	/// @param {real} [_right] The right padding. Defaults to the value of param `left`.
	/// @param {real} [_bottom] The bottom padding. Defaults to the value of param `left`.
	/// @return {CE_GUIContainer} Returns `self`.
	static SetPadding = function (_left) {
		gml_pragma("forceinline");
		PaddingLeft = _left;
		if (argument_count == 1)
		{
			PaddingTop = _left;
			PaddingRight = _left;
			PaddingBottom = _left;
		}
		else
		{
			PaddingTop = argument[1];
			PaddingRight = argument[2];
			PaddingBottom = argument[3];
		}
		return self;
	};

	/// @func Add(_widget)
	/// @desc Adds the widget to the container.
	/// @param {real} _widget The id of the widget.
	/// @return {CE_GUIContainer} Return `self`.
	static Add = function (_widget) {
		ce_assert(_widget.Gui == noone, "Widget is already added to a GUI.");
		ce_assert(_widget.Parent == noone, "Widget already has a parent.");
		if (Type == CE_EGuiWidget.Root)
		{
			_widget.Gui = self;
		}
		else
		{
			var _parentGui = Gui;
			ce_assert(_parentGui != noone, "Parent must be added to a GUI.");
			_widget.Gui = _parentGui;
			_widget.Parent = self;
		}
		ce_ds_list_add_unique(Widgets, _widget);
		return self;
	};

	/// @func Empty()
	/// @desc Destroys all child widgets of the container.
	/// @return {CE_GUIContainer} Returns `self`.
	static Empty = function () {
		var _widgets = Widgets;
		var _index = 0;
		repeat (ds_list_size(_widgets))
		{
			_widgets[| _index++].Destroy();
		}
		return self;
	};

	/// @func OnDrag(_event)
	/// @param {real} _event The id of the event.
	static OnDrag = function (_event) {
		var _redraw = false;

		if (ScrollXEnable)
		{
			var _scrollXOld = ScrollX;
			var _scrollX = clamp(_scrollXOld + _event.DiffX,
				0, max(ContentW - Width, 0));
			if (_scrollX != _scrollXOld)
			{
				ScrollX = _scrollX;
				_redraw = true;
			}
			_event.Propagate = false;
		}

		if (ScrollYEnable)
		{
			var _scrollYOld = ScrollY;
			var _scrollY = clamp(_scrollYOld + _event.DiffY,
				0, max(ContentH - Height, 0));
			if (_scrollY != _scrollYOld)
			{
				ScrollY = _scrollY;
				_redraw = true;
			}
			_event.Propagate = false;
		}

		if (_redraw)
		{
			Redraw = true;
		}
	};

	/// @func DrawItems()
	static DrawItems = function () {
		var _widgets = Widgets;
		var _index = 0;
		repeat (ds_list_size(_widgets))
		{
			_widgets[| _index++].Draw();
		}
	};

	static OnDraw = function () {
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;
		var _overflow = Overflow;
		var _redraw = Redraw;

		if (!_overflow)
		{
			gpu_push_state();
			var _surfaceOld = Surface;
			var _surface = ce_surface_check(_surfaceOld, _width, _height);
			if (_surface != _surfaceOld)
			{
				Surface = _surface;
				_redraw = true;
			}
			if (_redraw)
			{
				var _parent = Parent;
				if (_parent != noone)
				{
					_parent.Redraw = true;
				}
				Redraw = false;
				surface_set_target(_surface);
				draw_clear_alpha(0, 0);
				gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
				matrix_stack_push(matrix_get(matrix_world));
				matrix_set(matrix_world, matrix_build(-_x, -_y, 0, 0, 0, 0, 1, 1, 1));
				DrawBackground(_x, _y, _width, _height);
				DrawItems();
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
			DrawBackground(_x, _y, _width, _height);
			DrawItems();
		}
	};

	static OnCleanUp = function () {
		method(self, Super_Widget.OnCleanUp)();

		for (var i = ds_list_size(Widgets) - 1; i >= 0; --i)
		{
			Widgets[| i].OnCleanUp();
		}
		ds_list_destroy(Widgets);

		if (Surface != noone)
		{
			surface_free(Surface);
		}
	};
}