/// @var {real} The id of the GUI that is currently being rendered.
global.__ceGuiCurrent = noone;

/// @func CE_GUIRoot()
/// @extends CE_GUIContainer
/// @desc Root GUI widget.
function CE_GUIRoot()
	: CE_GUIContainer(CE_EGuiWidget.Root) constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Container = {
		OnDraw: OnDraw,
	};

	WidgetHovered = noone;
	WidgetDragging = noone;
	WidgetFocused = noone;
	Scale = 1;

	MouseDragXLast = 0;
	MouseDragYLast = 0;

	WidgetDraggable = noone;

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
		if (WidgetFocused != noone
			&& WidgetFocused.Type == CE_EGuiWidget.Input)
		{
			return true;
		}
		return false;
	};

	/// @func SetCurrentFont(_font)
	/// @param {real} _font The id of the font resource.
	/// @return {CE_GUIRoot} Returns `self`.
	static SetCurrentFont = function (_font) {
		if (_font == noone)
		{
			_font = Font;
		}
		if (_font != noone && draw_get_font() != _font)
		{
			draw_set_font(_font);
		}
		return self;
	};

	/// @func SetFocusedWidget(_widget)
	/// @param {real} _widget The id of the widget. Use `noone` for none.
	/// @return {CE_GUIRoot} Returns `self`.
	static SetFocusedWidget = function (_widget) {
		var _widgetPrev = WidgetFocused;

		WidgetFocused = _widget;

		if (_widgetPrev != noone)
		{
			var _ev = new CE_GUIEvent(CE_EGuiEvent.Blur);
			_widgetPrev.TriggerEvent(_ev);
			_ev.Destroy();
		}

		if (_widget != noone)
		{
			var _ev = new CE_GUIEvent(CE_EGuiEvent.Focus);
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
		WidgetHovered = noone;
		WidgetDraggable = noone;

		UpdatePosition(_mouseX, _mouseY);
		while (FixPositioning)
		{
			FixPositioning = false;
			UpdatePosition(_mouseX, _mouseY);
		}

		global.__ceGuiCurrent = noone;
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

		#region Proxy input
		var _focused = WidgetFocused;

		if (_focused != noone)
		{
			var _focusedX = _focused._xReal;
			var _focusedY = _focused._yReal;
			var _displayWidth = GetDisplayWidth();
			var _displayHeight = GetDisplayHeight();
			var _keyboardHeight = keyboard_virtual_height() ?? 0;

			if (rectangle_in_rectangle(_focusedX, _focusedY,
				_focusedX + _focused.Width, _focusedY + _focused.Height,
				0, 0, _displayWidth, _displayHeight - _keyboardHeight) == 0)
			{
				_focused.OnDrawProxy();
			}
		}
		#endregion Proxy input

		global.__ceGuiCurrent = noone;

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
			if (_parent != noone)
			{
				var _widgets = _parent.Widgets;
				var _idx = ds_list_find_index(_widgets, _widget);
				if (_idx != -1)
				{
					ds_list_delete(_widgets, _idx);
				}
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
	return (_root.WidgetHovered != noone);
}