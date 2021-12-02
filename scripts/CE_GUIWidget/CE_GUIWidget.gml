/// @func CE_GUIWidget([_props])
/// @desc Base class for GUI widgets.
/// @param {struct} [_props]
function CE_GUIWidget(_props={})
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	/// @var {string/undefined}
	Id = ce_struct_get(_props, "Id", undefined);

	/// @var {CE_GUIRoot/undefined}
	/// @readonly
	Root = undefined;

	/// @var {CE_GUIWidget/undefined}
	/// @readonly
	Parent = undefined;

	/// @var {ds_map<string, function>}
	/// @private
	Events = undefined;

	/// @var {bool}
	Visible = ce_struct_get(_props, "Visible", true);

	/// @var {bool}
	Redraw = true;

	/// @var {real} Mouse X position relative to the widget.
	/// Applicable only when the widget is hovered/clicked/...
	/// @readonly
	MouseX = 0;

	/// @var {real} Mouse Y position relative to the widget.
	/// Applicable only when the widget is hovered/clicked/...
	/// @readonly
	MouseY = 0;

	////////////////////////////////////////////////////////////////////////////
	// Position and size props

	/// @var {CE_EGUIPosition}
	Position = ce_struct_get(_props, "Position", CE_EGUIPosition.Scroll);

	/// @var {real}
	AlignH = ce_struct_get(_props, "AlignH", CE_EGUIAlign.Start);

	/// @var {real}
	AlignV = ce_struct_get(_props, "AlignV", CE_EGUIAlign.Start);

	/// @var {real}
	PivotX = ce_struct_get(_props, "PivotX", 0);

	/// @var {real}
	PivotY = ce_struct_get(_props, "PivotY", 0);

	/// @var {real}
	X = ce_struct_get(_props, "X", 0);

	/// @var {real}
	/// @readonly
	RealX = 0;

	/// @var {real}
	Y = ce_struct_get(_props, "Y", 0);

	/// @var {real}
	/// @readonly
	RealY = 0;

	/// @var {real}
	Width = ce_struct_get(_props, "Width", 1);

	/// @var {real}
	/// @readonly
	RealWidth = 0;

	/// @var {real}
	Height = ce_struct_get(_props, "Height", 1);

	/// @var {real}
	/// @readonly
	RealHeight = 0;

	/// @var {bool}
	Grow = ce_struct_get(_props, "Grow", false);

	////////////////////////////////////////////////////////////////////////////
	// Margin

	/// @var {real}
	MarginLeft = ce_struct_get(_props, "MarginLeft", 0);

	/// @var {real}
	MarginTop = ce_struct_get(_props, "MarginTop", 0);

	/// @var {real}
	MarginRight = ce_struct_get(_props, "MarginRight", 0);

	/// @var {real}
	MarginBottom = ce_struct_get(_props, "MarginBottom", 0);

	////////////////////////////////////////////////////////////////////////////
	// Padding

	/// @var {real}
	PaddingLeft = ce_struct_get(_props, "PaddingLeft", 0);

	/// @var {real}
	PaddingTop = ce_struct_get(_props, "PaddingTop", 0);

	/// @var {real}
	PaddingRight = ce_struct_get(_props, "PaddingRight", 0);

	/// @var {real}
	PaddingBottom = ce_struct_get(_props, "PaddingBottom", 0);

	////////////////////////////////////////////////////////////////////////////
	// Background props

	/// @var {uint}
	BackgroundColor = ce_struct_get(_props, "BackgroundColor", c_black);

	/// @var {real}
	BackgroundAlpha = ce_struct_get(_props, "BackgroundAlpha", 0);

	/// @var {sprite/undefined}
	BackgroundSprite = ce_struct_get(_props, "BackgroundSprite", undefined);

	/// @var {uint}
	BackgroundIndex = ce_struct_get(_props, "BackgroundIndex", 0);

	/// @var {CE_EGUIBackgroundStyle}
	BackgroundStyle = ce_struct_get(_props, "BackgroundStyle", CE_EGUIBackgroundStyle.Stretch);

	/// @var {uint}
	BackgroundSpriteBlend = ce_struct_get(_props, "BackgroundSpriteBlend", c_white);

	/// @var {real}
	BackgroundSpriteAlpha = ce_struct_get(_props, "BackgroundSpriteAlpha", 1);

	/// @var {bool} Applies only to nine-slice backgrounds.
	BackgroundTile = ce_struct_get(_props, "BackgroundTile", false);

	/// @var {real}
	BackgroundAlignH = ce_struct_get(_props, "BackgroundAlignH", 0);

	/// @var {real}
	BackgroundAlignV = ce_struct_get(_props, "BackgroundAlignV", 0);

	/// @var {real/undefined}
	BackgroundWidth = ce_struct_get(_props, "BackgroundWidth", undefined);

	/// @var {real/undefined}
	BackgroundHeight = ce_struct_get(_props, "BackgroundHeight", undefined);

	/// @var {real}
	BackgroundScaleX = ce_struct_get(_props, "BackgroundScaleX", 1);

	/// @var {real}
	BackgroundScaleY = ce_struct_get(_props, "BackgroundScaleY", 1);

	/// @var {real}
	BackgroundX = ce_struct_get(_props, "BackgroundX", 0);

	/// @var {real}
	BackgroundY = ce_struct_get(_props, "BackgroundY", 0);

	/// @var {real}
	BackgroundRot = ce_struct_get(_props, "BackgroundRot", 0);

	////////////////////////////////////////////////////////////////////////////
	// Text props

	/// @var {font/undefined}
	Font = ce_struct_get(_props, "Font", undefined);

	/// @var {uint}
	Color = ce_struct_get(_props, "Color", c_white);

	/// @var {real}
	Alpha = ce_struct_get(_props, "Color", 1);

	/// @var {string}
	Text = ce_struct_get(_props, "Text", "");

	/// @var {string}
	/// @readonly
	RealText = "";

	/// @var {bool}
	TextFormat = ce_struct_get(_props, "TextFormat", false);

	/// @var {real}
	TextAlignH = ce_struct_get(_props, "TextAlignH", CE_EGUIAlign.Start);

	/// @var {real}
	TextAlignV = ce_struct_get(_props, "TextAlignV", CE_EGUIAlign.Start);

	/// @func SetMargin(_left[, _top, _right, _bottom])
	/// @desc Sets the margin of the widget.
	/// @param {real} _left The left margin.
	/// @param {real} [_top] The top margin. Defaults to the value of param `left`.
	/// @param {real} [_right] The right margin. Defaults to the value of param `left`.
	/// @param {real} [_bottom] The bottom margin. Defaults to the value of param `left`.
	/// @return {CE_GUIWidget} Returns `self`.
	static SetMargin = function (_left) {
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

	/// @func SetMarginH(_margin)
	/// @param {real} _margin
	/// @return {CE_GUIWidget} Returns `self`.
	static SetMarginH = function (_margin) {
		gml_pragma("forceinline");
		MarginLeft = _margin;
		MarginRight = _margin;
		return self;
	};

	/// @func SetMarginV(_margin)
	/// @param {real} _margin
	/// @return {CE_GUIWidget} Returns `self`.
	static SetMarginV = function (_margin) {
		gml_pragma("forceinline");
		MarginTop = _margin;
		MarginBottom = _margin;
		return self;
	};

	/// @func SetPadding(_left[, _top, _right, _bottom])
	/// @desc Sets the padding of the widget.
	/// @param {real} _left The left padding.
	/// @param {real} [_top] The top padding. Defaults to the value of param `left`.
	/// @param {real} [_right] The right padding. Defaults to the value of param `left`.
	/// @param {real} [_bottom] The bottom padding. Defaults to the value of param `left`.
	/// @return {CE_GUIWidget} Returns `self`.
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

	/// @func SetPaddingH(_padding)
	/// @param {real} _padding
	/// @return {CE_GUIWidget} Returns `self`.
	static SetMarginH = function (_padding) {
		gml_pragma("forceinline");
		PaddingLeft = _padding;
		PaddingRight = _padding;
		return self;
	};

	/// @func SetPaddingV(_padding)
	/// @param {real} _padding
	/// @return {CE_GUIWidget} Returns `self`.
	static SetPaddingV = function (_padding) {
		gml_pragma("forceinline");
		PaddingTop = _padding;
		PaddingBottom = _padding;
		return self;
	};

	/// @func AddEventListener(_event, _listener)
	/// @desc TODO: Write script description.
	/// @param {typeof CE_GUIEvent} _event The event type.
	/// @param {real} _listener An id of a script that will be executed when
	/// the event occurs.
	/// @return {CE_GUIWidget} Returns `self`.
	static AddEventListener = function (_event, _listener) {
		var _eventMap = Events;
		if (_eventMap == undefined)
		{
			_eventMap = ds_map_create();
			Events = _eventMap;
		}

		var _eventType = CE_ClassGetName(_event);

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

	/// @func HasEventListener(_event)
	/// @desc Checks if the widget has a listener for the event.
	/// @param {typeof CE_GUIEvent} _event The event type.
	/// @return {bool} Returns `true` if the widget has a listener for the event.
	static HasEventListener = function (_event) {
		gml_pragma("forceinline");
		if (Events == undefined)
		{
			return false;
		}
		return ds_map_exists(Events, CE_ClassGetName(_event));
	};

	/// @func TriggerEvent(_event)
	/// @desc TODO: Write script desription.
	/// @param {real} _event The id of the event.
	static TriggerEvent = function (_event) {
		_event.Target ??= self;

		var _eventMap = Events;
		if (_eventMap == undefined)
		{
			return;
		}

		var _eventType = CE_ClassGetName(_event);

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

		if (_event.Propagate && Parent != undefined)
		{
			Parent.TriggerEvent(_event);
		}
	};

	/// @func FindHoveredWidget(_mouseX, _mouseY)
	/// @desc Recursively finds a widget underneath the mouse cursor.
	/// @param {real} _widget The widget to start searching from.
	/// @param {real} _mouseX The x position of the mouse cursor (relative to the
	/// widget's position).
	/// @param {real} _mouseY The y position of the mouse cursor (relative to the
	/// widget's position).
	/// @return {CE_GUIWidget/undefined} The hovered widget or `undefined`.
	static FindHoveredWidget = function (_mouseX, _mouseY) {
		if (!Visible)
		{
			return undefined;
		}

		var _x = RealX;
		var _y = RealY;
		var _width = Width;
		var _height = Height;

		MouseX = _mouseX - _x;
		MouseY = _mouseY - _y;

		if (!ce_point_in_rect(_mouseX, _mouseY, _x, _y, _width, _height))
		{
			return undefined;
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
			if (_hovered != undefined)
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

		var _root = Root;
		var _x = RealX;
		var _y = RealY;
		var _width = Width;
		var _height = Height;

		var _text = Text;
		if (TextFormat)
		{
			_text = ce_string_format(_text);
		}
		Root.SetCurrentFont(Font);
		var _widthNew = string_width(_text);
		var _heightNew = string_height(_text);
		if (_width < _widthNew
			|| _height < _heightNew)
		{
			_width = _widthNew;
			_height = _heightNew;
			Width = _width;
			Height = _height;
			_root.FixPositioning = true;
		}
		RealText = _text;

		MouseX = _mouseX;
		MouseY = _mouseY;

		if (ce_gui_mouse_in_rect(_x, _y, _width, _height))
		{
			if (_root != undefined)
			{
				_root.WidgetHovered = self;
				if (HasEventListener(CE_GUIDragEvent)
					|| HasEventListener(CE_GUIDragStartEvent)
					|| HasEventListener(CE_GUIDragEndEvent))
				{
					_root.WidgetDraggable = self;
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
			? ContentStyle : CE_EGUIContentStyle.Default;

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

		if (_contentStyle == CE_EGUIContentStyle.Grid)
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
				: CE_EGUIPosition.Scroll;

			#region Position style
			switch (_position)
			{
			case CE_EGUIPosition.Scroll:
				var _wWidth = _w.Width;
				var _wHeight = _w.Height;
				var __xReal, __yReal;

				if (_contentStyle == CE_EGUIContentStyle.Grid)
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
				case CE_EGUIContentStyle.Column:
					_drawY += _wHeight;
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
					break;

				case CE_EGUIContentStyle.Default:
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
					break;

				case CE_EGUIContentStyle.Grid:
					_drawX += _stepX;
					if (_drawX >= _width - _paddingRight)
					{
						_drawX = _paddingLeft;
						_drawY += _stepY;
					}
					_contentW = max(_drawX + _stepX, _contentW);
					_contentH = max(_drawY + _stepY, _contentH);
					break;

				case CE_EGUIContentStyle.Row:
					_drawX += _wWidth;
					_contentW = max(__xReal + _wWidth, _contentW);
					_contentH = max(__yReal + _wHeight, _contentH);
					break;
				}
				#endregion Content style
				break;

			case CE_EGUIPosition.Fixed:
				_wXReal = _x + _w.X + (_width - _w.Width) * _w.AlignH;
				_wYReal = _y + _w.Y + (_height - _w.Height) * _w.AlignV;
				break;

			default:
				ce_assert(false, "Unknown widget position property");
			}
			#endregion Position style

			_w.RealX = _wXReal;
			_w.RealY = _wYReal;

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
			if (_root != undefined)
			{
				_root.FixPositioning = true;
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
			var _backgroundAlignHor = BackgroundAlignH;
			var _backgroundAlignVer = BackgroundAlignV;

			switch (BackgroundStyle)
			{
			case CE_EGUIBackgroundStyle.Scale:
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

			case CE_EGUIBackgroundStyle.Stretch:
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

			case CE_EGUIBackgroundStyle.NineSlice:
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

	/// @func DrawText(_x, _y, _string[, _color[, _alpha[, _font]]])
	/// @desc Draws text at given position.
	/// @param {real} _x The x position to draw the text at.
	/// @param {real} _y The y position to draw the text at.
	/// @param {string} _string The text to draw.
	/// @param {real} [_color] The color of the text.
	/// @param {real} [_alpha] The alpha of the text.
	/// @param {font/undefined} [_font] The font resource to use.
	/// @return {CE_GUIWidget} Returns `self`.
	static DrawText = function (_x, _y, _string, _color=Color, _alpha=Alpha, _font=Font) {
		Root.SetCurrentFont(_font);
		draw_text_color(_x, _y, _string, _color, _color, _color, _color, _alpha);
		return self;
	};

	/// @func OnDraw()
	/// @desc Implements rendering of the widget.
	static OnDraw = function () {
		DrawBackground(RealX, RealY, Width, Height);
		DrawText(RealX, RealY, Text);
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

		if (Events != undefined)
		{
			ds_map_destroy(Events);
		}
	};

	/// @func Destroy()
	/// @desc Enqueues widget for destruction at the end of the frame.
	static Destroy = function () {
		Visible = false;
		ds_list_add(Root.DestroyList, self);
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
		if (variable_struct_exists(_widget, "Root"))
		{
			return true;
		}
	}
	catch (_ignore) {}
	return false;
}