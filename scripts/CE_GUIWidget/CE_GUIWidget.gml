/// @func CE_GUIWidget([_type])
/// @desc Base class for GUI widgets.
/// @param {CE_EGuiWidget} [_type]
function CE_GUIWidget(_type=CE_EGuiWidget.Widget)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	Type = _type;
	Id = undefined;
	X = 0;
	Y = 0;
	Width = 1;
	Height = 1;
	Gui = noone;
	Parent = noone;
	Events = noone;
	Font = noone;
	Visible = true;
	Position = CE_EGuiPosition.Scroll;

	// Pivot
	PivotX = 0;
	PivotY = 0;

	// Margin
	MarginLeft = 0;
	MarginTop = 0;
	MarginRight = 0;
	MarginBottom = 0;

	// Align within the parent widget
	AlignH = CE_EGuiAlign.Start;
	AlignV = CE_EGuiAlign.Start;

	// True calculated dimensions
	_xReal = 0;
	_yReal = 0;
	_widthReal = 0;
	_heightReal = 0;

	// Mouse coordinates relative to the widget position. Applicable only when
	// the widget is hovered/clicked/...
	MouseX = 0;
	MouseY = 0;

	// Background
	BackgroundColor = c_black;
	BackgroundAlpha = 0;
	BackgroundSprite = undefined;
	BackgroundIndex = 0;
	BackgroundStyle = CE_EGuiBackgroundStyle.Stretch;
	BackgroundSpriteBlend = c_white;
	BackgroundSpriteAlpha = 1;
	BackgroundTile = false; // Applies only to nine slice backgrounds.
	BackgroundAlignHor = 0;
	BackgroundAlignVer = 0;
	BackgroundWidth = undefined;
	BackgroundHeight = undefined;
	BackgroundScaleX = 1;
	BackgroundScaleY = 1;
	BackgroundX = 0;
	BackgroundY = 0;
	BackgroundRot = 0;

	/// @func SetMargin(_left[, _top, _right, _bottom])
	/// @desc Sets the margin of the widget.
	/// @param {real} _left The left margin.
	/// @param {real} [_top] The top margin. Defaults to the value of param `left`.
	/// @param {real} [_right] The right margin. Defaults to the value of param `left`.
	/// @param {real} [_bottom] The bottom margin. Defaults to the value of param `left`.
	/// @return {CE_GUIWidget} Returns `self`.
	static SetMargin = function (_left)	{
		gml_pragma("forceinline");
		MarginLeft = _left;
		if (argument_count == 1)
		{
			MarginTop = _left;
			MarginRight = _left;
			MarginBottom = _left;
		}
		else
		{
			MarginTop = argument[1];
			MarginRight = argument[2];
			MarginBottom = argument[3];
		}
		return self;
	};

	/// @func AddEventListener(_eventType, _listener)
	/// @desc TODO Write script description.
	/// @param {CE_EGuiEvent} _eventType The event type.
	/// @param {real} _listener An id of a script that will be executed when
	/// the event occurs.
	/// @return {CE_GUIWidget} Returns `self`.
	static AddEventListener = function (_eventType, _listener) {
		var _eventMap = Events;
		if (_eventMap == noone)
		{
			_eventMap = ds_map_create();
			Events = _eventMap;
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

		return self;
	};

	/// @func TriggerEvent(_event)
	/// @desc TODO Write script desription.
	/// @param {real} _event The id of the event.
	static TriggerEvent = function (_event) {
		_event.Target = self;

		var _eventMap = Events;
		if (!ds_exists(_eventMap, ds_type_map))
		{
			return;
		}

		var _eventType = _event.Type;

		if (!ds_map_exists(_eventMap, _eventType))
		{
			return;
		}

		var _listeners = _eventMap[? _eventType];
		var _size = ds_list_size(_listeners);

		for (var i = 0; i < _size; ++i)
		{
			_listeners[| i](_event);
		}
	};

	/// @func FindHoveredWidget(_mouseX, _mouseY)
	/// @desc Recursively finds a widget underneath the mouse cursor.
	/// @param {real} _widget The widget to start searching from.
	/// @param {real} _mouseX The x position of the mouse cursor (relative to the
	/// widget's position).
	/// @param {real} _mouseY The y position of the mouse cursor (relative to the
	/// widget's position).
	/// @return {real} The id of the hovered widget or `noone`.
	static FindHoveredWidget = function (_mouseX, _mouseY) {
		if (!Visible)
		{
			return noone;
		}

		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;

		MouseX = _mouseX - _x;
		MouseY = _mouseY - _y;

		if (!ce_point_in_rect(_mouseX, _mouseY, _x, _y, _width, _height))
		{
			return noone;
		}

		Redraw = true;

		if (!variable_struct_exists(self, "Widgets"))
		{
			return self;
		}

		var _widgets = Widgets;
		for (var i = ds_list_size(_widgets) - 1; i >= 0; --i)
		{
			var _hovered = _widgets[| i].FindHoveredWidget(_mouseX - _x, _mouseY - _y);
			if (_hovered != noone)
			{
				return _hovered;
			}
		}

		return self;
	};

	/// @func IsMouseOver()
	/// @return {bool} Returns `true` if the mouse is over the widget.
	static IsMouseOver = function () {
		gml_pragma("forceinline");
		return (global.__ceGuiCurrent.WidgetHovered == self);
	};

	/// @func SetRectangle(_x, _y, _width, _height)
	/// @desc Sets the position and the size of the widget to given values.
	/// @param {real} _x The new x position of the widget.
	/// @param {real} _y The new y position of the widget.
	/// @param {real} _width The new width of the widget.
	/// @param {real} _height The new height of the widget.
	/// @return {CE_GUIWidget} Returns `self`.
	static SetRectangle = function (_x, _y, _width, _height) {
		gml_pragma("forceinline");
		X = _x;
		Y = _y;
		Width = _width;
		Height = _height;
		return self;
	};

	/// @func UpdatePosition(_mouseX, _mouseY)
	/// @param {real} _mouseX The mouse x position relative to the widget.
	/// @param {real} _mouseY The mouse y position relative to the widget.
	/// @return {CE_GUIWidget} Returns `self`.
	static UpdatePosition = function (_mouseX, _mouseY) {
		if (!Visible)
		{
			return;
		}

		var _gui = Gui;
		var _x = _xReal;
		var _y = _yReal;
		var _width = Width;
		var _height = Height;

		if (Type == CE_EGuiWidget.Text)
		{
			var _text = Text;
			if (Format)
			{
				_text = ce_string_format(_text);
			}
			Gui.SetCurrentFont(Font);
			var _widthNew = string_width(_text);
			var _heightNew = string_height(_text);
			if (_width != _widthNew
				|| _height != _heightNew)
			{
				_width = _widthNew;
				_height = _heightNew;
				Width = _width;
				Height = _height;
				_gui.FixPositioning = true;
			}
			_textReal = _text;
		}

		MouseX = _mouseX;
		MouseY = _mouseY;

		if (ce_gui_mouse_in_rect(_x, _y, _width, _height))
		{
			if (_gui != noone)
			{
				_gui.WidgetHovered = self;
				var _eventMap = Events;
				if (ds_exists(_eventMap, ds_type_map)
					&& ds_map_exists(_eventMap, CE_EGuiEvent.Drag))
				{
					_gui.WidgetDraggable = self;
				}
			}
			Redraw = true;
		}

		if (!variable_struct_exists(self, "Widgets"))
		{
			return;
		}

		var _scrollX = variable_struct_exists(self, "ScrollX") ? ScrollX : 0;
		var _scrollY = variable_struct_exists(self, "ScrollY") ? ScrollY : 0;
		var _xScroll = _x - _scrollX;
		var _yScroll = _y - _scrollY;

		var _contentStyle = variable_struct_exists(self, "ContentStyle")
			? ContentStyle : CE_EGuiContentStyle.Default;

		var _contentW = 0;
		var _contentH = 0;

		var _paddingLeft = PaddingLeft;
		var _paddingTop = PaddingTop;
		var _paddingRight = PaddingRight;
		var _paddingBottom = PaddingBottom;

		var _drawX = _paddingLeft;
		var _drawY = _paddingTop;
		var _stepX = 0;
		var _stepY = 0;

		if (_contentStyle == CE_EGuiContentStyle.Grid)
		{
			_stepX += (_width - _paddingRight - _paddingLeft) / GridColumns;
			_stepY += (_height - _paddingBottom - _paddingTop) / GridRows;
		}

		var _widgets = Widgets;
		var _widgetCount = ds_list_size(_widgets);

		for (var i = 0; i < _widgetCount; ++i)
		{
			var _w = _widgets[| i];

			if (!Visible)
			{
				continue;
			}

			var _wXReal = 0;
			var _wYReal = 0;
			var _position = variable_struct_exists(_w, "Position")
				? _w.Position
				: CE_EGuiPosition.Scroll;

			#region Position style
			switch (_position)
			{
			case CE_EGuiPosition.Scroll:
				var _wWidth = _w.Width;
				var _wHeight = _w.Height;
				var __xReal, __yReal;

				if (_contentStyle == CE_EGuiContentStyle.Grid)
				{
					__xReal = _drawX + _w.X + (_stepX - _wWidth) * _w.AlignH;
					__yReal = _drawY + _w.Y + (_stepY - _wHeight) * _w.AlignV;
				}
				else
				{
					_drawX += _w.MarginLeft;
					_drawY += _w.MarginTop;
					__xReal = _drawX + _w.X + (_width - _wWidth) * _w.AlignH;
					__yReal = _drawY + _w.Y + (_height - _wHeight) * _w.AlignV;
					_drawX += _w.MarginRight;
					_drawY += _w.MarginBottom;
				}

				_wXReal = _xScroll + __xReal;
				_wYReal = _yScroll + __yReal;

				#region Content style
				switch (_contentStyle)
				{
				case CE_EGuiContentStyle.Column:
					_drawY += _wHeight;
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
					break;

				case CE_EGuiContentStyle.Default:
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
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
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
					break;
				}
				#endregion Content style
				break;

			case CE_EGuiPosition.Fixed:
				_wXReal = _x + _w.X + (_width - _w.Width) * _w.AlignH;
				_wYReal = _y + _w.Y + (_height - _w.Height) * _w.AlignV;
				break;

			default:
				ce_assert(false, "Unknown widget position property");
			}
			#endregion Position style

			_w._xReal = _wXReal;
			_w._yReal = _wYReal;

			_w.UpdatePosition(_mouseX + _x - _wXReal, _mouseY + _y - _wYReal);
		}

		_contentW += _paddingRight;
		_contentH += _paddingBottom;

		ContentW = _contentW;
		ContentH = _contentH;

		if (Grow
			&& (_width != _contentW
			|| _height != _contentH))
		{
			Width = _contentW;
			Height = _contentH;
			if (_gui != noone)
			{
				_gui.FixPositioning = true;
			}
		}

		return self;
	};

	/// @func DrawBackground(_x, _y, _width, _height)
	/// @param {real} _x The x position of the background.
	/// @param {real} _y The y position of the background.
	/// @param {real} _width The width of the background.
	/// @param {real} _height The height of the background.
	/// @return {CE_GUIWidget} Returns `self`.
	static DrawBackground = function (_x, _y, _width, _height) {
		#region Background color
		var _backgroundAlpha = BackgroundAlpha;
		if (_backgroundAlpha > 0)
		{
			ce_draw_rectangle(_x, _y, _width, _height, BackgroundColor, _backgroundAlpha);
		}
		#endregion Background color

		#region Background sprite
		var _backgroundSprite = BackgroundSprite;
		if (!is_undefined(_backgroundSprite))
		{
			var _backgroundIndex = BackgroundIndex;
			var _backgroundX = _x + BackgroundX;
			var _backgroundY = _y + BackgroundY;
			var _backgroundWidth = BackgroundWidth;
			var _backgroundHeight = BackgroundHeight;
			var _backgroundSpriteBlend = BackgroundSpriteBlend;
			var _backgroundSpriteAlpha = BackgroundSpriteAlpha;
			var _backgroundAlignHor = BackgroundAlignHor;
			var _backgroundAlignVer = BackgroundAlignVer;

			switch (BackgroundStyle)
			{
			case CE_EGuiBackgroundStyle.Scale:
				var _backgroundScaleX = BackgroundScaleX;
				var _backgroundScaleY = BackgroundScaleY;

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
					_backgroundScaleX, _backgroundScaleY, BackgroundRot, _backgroundSpriteBlend,
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
				//	_backgroundX, _backgroundY, _width, _height, BackgroundTile,
				//	_backgroundSpriteBlend, _backgroundSpriteAlpha);
				break;
			}
		}
		#endregion Background sprite
	};

	/// @func OnDraw()
	/// @desc Implements rendering of the widget.
	static OnDraw = function () {
		DrawBackground(_xReal, _yReal, Width, Height);
	};

	/// @func OnDrawProxy()
	/// @desc Render proxy when the widget is underneath the keyboard.
	static OnDrawProxy = function () {
	};

	/// @func Draw()
	/// @desc Draws the widget, if it's visible.
	/// @return {CE_GUIWidget} Returns `self`.
	static Draw = function () {
		if (!Visible)
		{
			return;
		}
		OnDraw();
		return self;
	};

	/// @func OnCleanUp()
	/// @desc A function executed when the widget is destroyed.
	static OnCleanUp = function () {
		method(self, Super_Class.Destroy)();

		if (ds_exists(Events, ds_type_map))
		{
			ds_map_destroy(Events);
		}
	};

	/// @func Destroy()
	/// @desc Enqueues widget for destruction at the end of the frame.
	static Destroy = function () {
		Visible = false;
		ds_list_add(Gui.DestroyList, self);
	};
}

/// @func ce_gui_widget_exists(_widget)
/// @param {CE_GUIWidget} _widget The id of the widget.
/// @return {bool} True if the widget exists.
function ce_gui_widget_exists(_widget)
{
	gml_pragma("forceinline");
	try
	{
		if (variable_struct_exists(_widget, "Gui"))
		{
			return true;
		}
	}
	catch (_ignore) {}
	return false;
}