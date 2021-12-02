/// @var {CE_GUIRoot/undefined}
/// @private
global.__ceGuiCurrent = undefined;

/// @func CE_GUIRoot()
/// @extends CE_GUIContainer
/// @desc Root GUI widget.
function CE_GUIRoot()
	: CE_GUIContainer() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Container = {
		OnDraw: OnDraw,
	};

	Root = self;

	WidgetHovered = undefined;
	WidgetDragging = undefined;
	WidgetFocused = undefined;
	Scale = 1;

	MouseDragXLast = 0;
	MouseDragYLast = 0;

	WidgetDraggable = undefined;

	FixPositioning = false;

	DestroyList = ds_list_create();

	/// @func GetDisplayWidth()
	/// @return {real} The width of the display within the GUI.
	static GetDisplayWidth = function () {
		gml_pragma("forceinline");
		return window_get_width() / Scale;
	};

	/// @func GetDisplayHeight()
	/// @return {real} The width of the display within the GUI.
	static GetDisplayHeight = function () {
		gml_pragma("forceinline");
		return window_get_height() / Scale;
	};

	/// @func IsTyping()
	/// @return {bool}
	static IsTyping = function () {
		if (keyboard_virtual_status())
		{
			return true;
		}
		if (WidgetFocused != undefined
			&& WidgetFocused.IsInstance(CE_GUIInput))
		{
			return true;
		}
		return false;
	};

	/// @func SetCurrentFont([_font])
	/// @param {font} [_font] The font resource.
	/// @return {CE_GUIRoot} Returns `self`.
	static SetCurrentFont = function (_font=Font) {
		if (_font != undefined
			&& draw_get_font() != _font)
		{
			draw_set_font(_font);
		}
		return self;
	};

	/// @func SetFocusedWidget(_widget)
	/// @param {CE_GUIWidget/undefined} _widget The widget or `undefined`.
	/// @return {CE_GUIRoot} Returns `self`.
	static SetFocusedWidget = function (_widget) {
		var _widgetPrev = WidgetFocused;

		WidgetFocused = _widget;

		if (_widgetPrev != undefined)
		{
			var _ev = new CE_GUIBlurEvent();
			_widgetPrev.TriggerEvent(_ev);
			_ev.Destroy();
		}

		if (_widget != undefined)
		{
			var _ev = new CE_GUIFocusEvent();
			_widget.TriggerEvent(_ev);
			_ev.Destroy();
		}

		return self;
	};

	static OnUpdate = function () {
		global.__ceGuiCurrent = self;

		SetRectangle(0, 0, GetDisplayWidth(), GetDisplayHeight());

		var _mouseX = device_mouse_x_to_gui(0);
		var _mouseY = device_mouse_y_to_gui(0);

		MouseX = _mouseX;
		MouseY = _mouseY;
		WidgetHovered = undefined;
		WidgetDraggable = undefined;

		UpdatePosition(_mouseX, _mouseY);
		while (FixPositioning)
		{
			FixPositioning = false;
			UpdatePosition(_mouseX, _mouseY);
		}

		global.__ceGuiCurrent = undefined;
	};

	static OnDraw = function () {
		if (!Visible)
		{
			return;
		}

		gpu_push_state();
		gpu_set_tex_filter(true);

		var _font = draw_get_font();

		global.__ceGuiCurrent = self;
		method(self, Super_Container.OnDraw)();

		#region Proxy widget
		var _focused = WidgetFocused;
		if (_focused != undefined)
		{
			var _focusedX = _focused.RealX;
			var _focusedY = _focused.RealY;
			var _displayWidth = GetDisplayWidth();
			var _displayHeight = GetDisplayHeight();
			var _keyboardHeight = keyboard_virtual_height() ?? 0;

			if (rectangle_in_rectangle(_focusedX, _focusedY,
				_focusedX + _focused.Width, _focusedY + _focused.Height,
				0, 0, _displayWidth, _displayHeight - _keyboardHeight / Scale) != 1)
			{
				_focused.OnDrawProxy();
			}
		}
		#endregion Proxy widget

		global.__ceGuiCurrent = undefined;

		#region Destroy widgets
		var _destroyList = DestroyList;

		for (var i = ds_list_size(_destroyList) - 1; i >= 0; --i)
		{
			var _widget = _destroyList[| i];
			if (!ce_gui_widget_exists(_widget))
			{
				continue;
			}
			#region Remove from parent
			var _parent = _widget.Parent;
			if (_parent != undefined)
			{
				ce_ds_list_remove(_parent.Widgets, _widget);
			}
			#endregion Remove from parent
			_widget.OnCleanUp();
		}
		ds_list_clear(_destroyList);
		#endregion Destroy widgets

		if (draw_get_font() != _font)
		{
			draw_set_font(_font);
		}

		gpu_pop_state();
	};

	/// @func Destroy()
	/// @desc Destroys the widget.
	static Destroy = function () {
		OnCleanUp();
	};
}

/// @func ce_is_mouse_over_gui(_root)
/// @param {CE_GUIRoot} _root The id of the GUI.
/// @return {bool} Returns `true` if mouse is over some GUI element.
function ce_is_mouse_over_gui(_root)
{
	gml_pragma("forceinline");
	return (_root.WidgetHovered != undefined);
}