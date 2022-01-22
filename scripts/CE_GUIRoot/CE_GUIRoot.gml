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
		Update: Update,
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

	WindowInit = true;

	WindowSizePrev = [0, 0];

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

	static KeyDownAny = function () {
		var _focused = WidgetFocused;
		if (_focused != undefined)
		{
			var _ev = new CE_GUIKeyDownEvent(keyboard_key);
			_focused.TriggerEvent(_ev);
			_ev.Destroy();
		}
	};

	static KeyPressAny = function () {
		var _focused = WidgetFocused;
		if (_focused != undefined)
		{
			var _ev = new CE_GUIKeyPressEvent(keyboard_key);
			_focused.TriggerEvent(_ev);
			_ev.Destroy();
		}
	};

	static KeyPressEnter = function () {
		// Fixes returning from input on Android
		var _focused = WidgetFocused;
		if (_focused != undefined)
		{
			var _ev = new CE_GUIKeyPressEvent(vk_enter);
			_focused.TriggerEvent(_ev);
			_ev.Destroy();
		}
	};

	static GlobalLeftPressed = function () {
		// Required for plaforms with touch controls only
		_Update();
	};

	static GlobalTap = function () {
		var _hovered = WidgetHovered;
		if (WidgetFocused != _hovered)
		{
			SetFocusedWidget(_hovered);
		}
		if (_hovered != undefined)
		{
			var _event = new CE_GUIClickEvent(mb_left);
			_hovered.TriggerEvent(_event);
			_event.Destroy();
		}
	};

	static GlobalDragStart = function () {
		var _draggable = WidgetDraggable;
		if (_draggable != undefined)
		{
			if (WidgetFocused != undefined)
			{
				SetFocusedWidget(undefined);
			}
			WidgetDragging = _draggable;
			MouseDragXLast = MouseX;
			MouseDragYLast = MouseY;
			var _event = new CE_GUIDragStartEvent();
			_draggable.TriggerEvent(_event);
			_event.Destroy();
		}
	};

	static GlobalDragEnd = function () {
		var _dragging = WidgetDragging;
		if (_dragging != undefined)
		{
			var _event = new CE_GUIDragEndEvent();
			_dragging.TriggerEvent(_event);
			_event.Destroy();
			WidgetDragging = noone;
		}
	};

	static GlobalDragging = function () {
		var _dragging = WidgetDragging;
		if (_dragging != undefined)
		{
			var _mouseX = MouseX;
			var _mouseY = MouseY;
			var _event = new CE_GUIDragEvent(
				MouseDragXLast - _mouseX,
				MouseDragYLast - _mouseY);
			_dragging.TriggerEvent(_event);
			_event.Destroy();
			MouseDragXLast = _mouseX;
			MouseDragYLast = _mouseY;
		}
	};

	static _Update = function () {
		global.__ceGuiCurrent = self;

		SetRectangle(0, 0, GetDisplayWidth(), GetDisplayHeight());
		RealX = 0;
		RealY = 0;
		RealWidth = Width;
		RealHeight = Height;

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

	static Update = function () {
		method(self, Super_Container.Update)();

		var _windowWidth = window_get_width();
		var _windowHeight = window_get_height();

		if (WindowInit
			|| _windowWidth != WindowSizePrev[0]
			|| _windowHeight != WindowSizePrev[1])
		{
			var _scale;
			if (_windowWidth > _windowHeight)
			{
				_scale = CE_ScaleKeepAspectRatio(
					_windowWidth,
					_windowHeight,
					CE_DESIGN_SCREEN_WIDTH,
					CE_DESIGN_SCREEN_HEIGHT);
			}
			else
			{
				_scale = CE_ScaleKeepAspectRatio(
					_windowWidth,
					_windowHeight,
					CE_DESIGN_SCREEN_HEIGHT,
					CE_DESIGN_SCREEN_WIDTH);
			}

			display_set_gui_size(_windowWidth, _windowHeight);
			display_set_gui_maximize(_scale, _scale);
			Scale = _scale;

			WindowSizePrev = [
				_windowWidth,
				_windowHeight
			];

			WindowInit = false;
		}

		_Update();

		return self;
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
				_focusedX + _focused.RealWidth, _focusedY + _focused.RealHeight,
				0, 0, _displayWidth, _displayHeight - (_keyboardHeight / Scale)) != 1)
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
				CE_ListRemove(_parent.Widgets, _widget);
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