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
	Id = CE_StructGet(_props, "Id", undefined);

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
	Visible = CE_StructGet(_props, "Visible", true);

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

	/// @var {function/undefined}
	OnUpdate = CE_StructGet(_props, "OnUpdate", undefined);

	////////////////////////////////////////////////////////////////////////////
	// Position and size props

	/// @var {CE_EGUIPosition}
	Position = CE_StructGet(_props, "Position", CE_EGUIPosition.Scroll);

	/// @var {real}
	AlignH = CE_StructGet(_props, "AlignH", CE_EGUIAlign.Start);

	/// @var {real}
	AlignV = CE_StructGet(_props, "AlignV", CE_EGUIAlign.Start);

	/// @var {real}
	PivotX = CE_StructGet(_props, "PivotX", 0);

	/// @var {real}
	PivotY = CE_StructGet(_props, "PivotY", 0);

	/// @var {real}
	X = CE_StructGet(_props, "X", 0);

	/// @var {real}
	/// @readonly
	RealX = 0;

	/// @var {real}
	Y = CE_StructGet(_props, "Y", 0);

	/// @var {real}
	/// @readonly
	RealY = 0;

	/// @var {real}
	Width = CE_StructGet(_props, "Width", 1);

	/// @var {real}
	/// @readonly
	RealWidth = 0;

	/// @var {bool}
	WidthRelative = CE_StructGet(_props, "WidthRelative", false);

	/// @var {real}
	Height = CE_StructGet(_props, "Height", 1);

	/// @var {real}
	/// @readonly
	RealHeight = 0;

	/// @var {bool}
	HeightRelative = CE_StructGet(_props, "HeightRelative", false);

	/// @var {bool}
	Grow = CE_StructGet(_props, "Grow", false);

	////////////////////////////////////////////////////////////////////////////
	// Margin

	/// @var {real}
	MarginLeft = CE_StructGet(_props, "MarginLeft", 0);

	/// @var {real}
	MarginTop = CE_StructGet(_props, "MarginTop", 0);

	/// @var {real}
	MarginRight = CE_StructGet(_props, "MarginRight", 0);

	/// @var {real}
	MarginBottom = CE_StructGet(_props, "MarginBottom", 0);

	////////////////////////////////////////////////////////////////////////////
	// Padding
	var _padding = CE_StructGet(_props, "Padding", undefined);
	var _paddingH = CE_StructGet(_props, "PaddingH", undefined);
	var _paddingV = CE_StructGet(_props, "PaddingV", undefined);

	/// @var {real}
	PaddingLeft = (((CE_StructGet(_props, "PaddingLeft", undefined)
		?? _paddingH)
		?? _padding)
		?? 0);

	/// @var {real}
	PaddingTop = (((CE_StructGet(_props, "PaddingTop", undefined)
		?? _paddingV)
		?? _padding)
		?? 0);

	/// @var {real}
	PaddingRight = (((CE_StructGet(_props, "PaddingRight", undefined)
		?? _paddingH)
		?? _padding)
		?? 0);

	/// @var {real}
	PaddingBottom = (((CE_StructGet(_props, "PaddingBottom", undefined)
		?? _paddingV)
		?? _padding)
		?? 0);

	////////////////////////////////////////////////////////////////////////////
	// Background props

	/// @var {uint}
	BackgroundColor = CE_StructGet(_props, "BackgroundColor", c_black);

	/// @var {real}
	BackgroundAlpha = CE_StructGet(_props, "BackgroundAlpha", 0);

	/// @var {sprite/undefined}
	BackgroundSprite = CE_StructGet(_props, "BackgroundSprite", undefined);

	/// @var {uint}
	BackgroundIndex = CE_StructGet(_props, "BackgroundIndex", 0);

	/// @var {CE_EGUIBackgroundStyle}
	BackgroundStyle = CE_StructGet(_props, "BackgroundStyle", CE_EGUIBackgroundStyle.Stretch);

	/// @var {bool} Applies only to nine-slice backgrounds.
	BackgroundTile = CE_StructGet(_props, "BackgroundTile", false);

	/// @var {real}
	BackgroundAlignH = CE_StructGet(_props, "BackgroundAlignH", 0);

	/// @var {real}
	BackgroundAlignV = CE_StructGet(_props, "BackgroundAlignV", 0);

	/// @var {real/undefined}
	BackgroundWidth = CE_StructGet(_props, "BackgroundWidth", undefined);

	/// @var {real/undefined}
	BackgroundHeight = CE_StructGet(_props, "BackgroundHeight", undefined);

	/// @var {real}
	BackgroundScaleX = CE_StructGet(_props, "BackgroundScaleX", 1);

	/// @var {real}
	BackgroundScaleY = CE_StructGet(_props, "BackgroundScaleY", 1);

	/// @var {real}
	BackgroundX = CE_StructGet(_props, "BackgroundX", 0);

	/// @var {real}
	BackgroundY = CE_StructGet(_props, "BackgroundY", 0);

	/// @var {real}
	BackgroundRot = CE_StructGet(_props, "BackgroundRot", 0);

	////////////////////////////////////////////////////////////////////////////
	// Text props

	/// @var {font/undefined}
	Font = CE_StructGet(_props, "Font", undefined);

	/// @var {real}
	FontScale = CE_StructGet(_props, "FontScale", 1);

	/// @var {uint}
	Color = CE_StructGet(_props, "Color", c_white);

	/// @var {real}
	Alpha = CE_StructGet(_props, "Color", 1);

	/// @var {string}
	Text = CE_StructGet(_props, "Text", "");

	/// @var {string}
	/// @readonly
	RealText = "";

	/// @var {bool}
	TextFormat = CE_StructGet(_props, "TextFormat", false);

	/// @var {real}
	TextAlignH = CE_StructGet(_props, "TextAlignH", CE_EGUIAlign.Start);

	/// @var {real}
	TextAlignV = CE_StructGet(_props, "TextAlignV", CE_EGUIAlign.Start);

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
	/// @desc Adds an event listener to the widget.
	/// @param {typeof CE_GUIEvent} _event The event type.
	/// @param {function} _listener An function that will be executed when
	/// the event is triggered.
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

		CE_ListAddUnique(_listeners, _listener);

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
	/// @desc Triggers an event in the widget.
	/// @param {CE_GUIEvent} _event The event to trigger.
	/// @return {CE_GUIWidget} Returns `self`.
	static TriggerEvent = function (_event) {
		_event.Target ??= self;

		var _eventMap = Events;
		if (_eventMap != undefined)
		{
			var _eventType = CE_ClassGetName(_event);
			if (ds_map_exists(_eventMap, _eventType))
			{
				var _listeners = _eventMap[? _eventType];
				var _size = ds_list_size(_listeners);
				for (var i = 0; i < _size; ++i)
				{
					_listeners[| i](_event);
				}
			}
		}

		if (_event.Propagate && Parent != undefined)
		{
			Parent.TriggerEvent(_event);
		}

		return self;
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
		var _width = RealWidth;
		var _height = RealHeight;

		MouseX = _mouseX - _x;
		MouseY = _mouseY - _y;

		if (!CE_PointInRectangle(_mouseX, _mouseY, _x, _y, _width, _height))
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
	/// @desc Checks if the mouse cursor is over the widget.
	/// @return {bool} Returns `true` if the mouse cursor is over the widget.
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

	static PrecomputeSize = function () {
		if (!Visible)
		{
			return self;
		}

		var _width = Width;
		var _height = Height;

		var _text = Text;
		if (TextFormat)
		{
			_text = CE_StringFormat(_text);
		}
		RealText = _text;

		if (Grow)
		{
			Root.SetCurrentFont(Font);
			var _textWidth = (string_width(_text) * FontScale) + PaddingLeft + PaddingRight;
			var _textHeight = (string_height(_text) * FontScale) + PaddingTop + PaddingBottom;
			if (_width < _textWidth)
			{
				_width = _textWidth;
			}
			if (_height < _textHeight)
			{
				_height = _textHeight;
			}
		}

		RealWidth = _width;
		RealHeight = _height;

		return self;
	};

	/// @func UpdatePosition(_mouseX, _mouseY)
	/// @desc Updates the widget's position.
	/// @param {real} _mouseX The mouse x position relative to the widget.
	/// @param {real} _mouseY The mouse y position relative to the widget.
	/// @return {CE_GUIWidget} Returns `self`.
	static UpdatePosition = function (_mouseX, _mouseY) {
		if (!Visible)
		{
			return self;
		}

		var _root = Root;
		var _x = RealX;
		var _y = RealY;
		var _width = RealWidth;
		var _height = RealHeight;

		MouseX = _mouseX;
		MouseY = _mouseY;

		if (CE_GUIMouseInRect(_x, _y, _width, _height))
		{
			_root.WidgetHovered = self;
			if (HasEventListener(CE_GUIDragEvent)
				|| HasEventListener(CE_GUIDragStartEvent)
				|| HasEventListener(CE_GUIDragEndEvent))
			{
				_root.WidgetDraggable = self;
			}
			Redraw = true;
		}

		return self;
	};

	/// @func Update()
	/// @return {CE_GUIWidget} Returns `self`.
	static Update = function () {
		if (OnUpdate != undefined)
		{
			OnUpdate(self);
		}
		return self;
	};

	/// @func DrawBackground()
	/// @desc Draws the background of the widget.
	/// @return {CE_GUIWidget} Returns `self`.
	static DrawBackground = function () {
		var _x = RealX;
		var _y = RealY;
		var _width = RealWidth;
		var _height = RealHeight;
		var _backgroundSprite = BackgroundSprite;

		#region Background color
		if (_backgroundSprite == undefined)
		{
			var _backgroundAlpha = BackgroundAlpha;
			if (_backgroundAlpha > 0)
			{
				var _backgroundWidth = (BackgroundWidth ?? _width) * BackgroundScaleX;
				var _backgroundHeight = (BackgroundHeight ?? _height) * BackgroundScaleY;
				var _backgroundX = round(_x + BackgroundX + (_width - _backgroundWidth) * BackgroundAlignH);
				var _backgroundY = round(_y + BackgroundY + (_height - _backgroundHeight) * BackgroundAlignV);
				CE_DrawRectangle(_backgroundX, _backgroundY, _backgroundWidth, _backgroundHeight, BackgroundColor, _backgroundAlpha);
			}
		}
		#endregion Background color

		#region Background sprite
		if (_backgroundSprite != undefined)
		{
			var _backgroundIndex = BackgroundIndex;
			var _backgroundWidth = BackgroundWidth;
			var _backgroundHeight = BackgroundHeight;

			switch (BackgroundStyle)
			{
			case CE_EGUIBackgroundStyle.Scale:
				var _backgroundScaleX = BackgroundScaleX;
				var _backgroundScaleY = BackgroundScaleY;

				_backgroundWidth = sprite_get_width(_backgroundSprite) * _backgroundScaleX;
				_backgroundHeight = sprite_get_height(_backgroundSprite) * _backgroundScaleY;

				var _backgroundX = round(_x + BackgroundX + (_width - _backgroundWidth) * BackgroundAlignH);
				var _backgroundY = round(_y + BackgroundY + (_height - _backgroundHeight) * BackgroundAlignV);

				draw_sprite_ext(_backgroundSprite, _backgroundIndex, _backgroundX, _backgroundY,
					_backgroundScaleX, _backgroundScaleY, BackgroundRot, BackgroundColor,
					BackgroundAlpha);
				break;

			case CE_EGUIBackgroundStyle.Fit:
				var _spriteWidth = sprite_get_width(_backgroundSprite);
				var _spriteHeight = sprite_get_width(_backgroundSprite);
				var _scale = CE_ScaleKeepAspectRatio(
					_backgroundWidth ?? _width,
					_backgroundHeight ?? _height,
					_spriteWidth,
					_spriteHeight);

				var _backgroundX = round(_x + BackgroundX + (_width - (_spriteWidth * _scale)) * BackgroundAlignH);
				var _backgroundY = round(_y + BackgroundY + (_height - (_spriteHeight * _scale)) * BackgroundAlignV);

				draw_sprite_ext(_backgroundSprite, _backgroundIndex, _backgroundX, _backgroundY,
					_scale, _scale, 0, BackgroundColor,
					BackgroundAlpha);
				break;

			case CE_EGUIBackgroundStyle.Stretch:
				_backgroundWidth ??= _width;
				_backgroundHeight ??= _height;

				var _backgroundX = round(_x + BackgroundX + (_width - _backgroundWidth) * BackgroundAlignH);
				var _backgroundY = round(_y + BackgroundY + (_height - _backgroundHeight) * BackgroundAlignV);

				draw_sprite_stretched_ext(_backgroundSprite, _backgroundIndex,
					_backgroundX, _backgroundY, _width, _height, BackgroundColor,
					BackgroundAlpha);
				break;

			case CE_EGUIBackgroundStyle.NineSlice:
				_backgroundWidth ??= _width;
				_backgroundHeight ??= _height;

				var _backgroundX = round(_x + BackgroundX + (_width - _backgroundWidth) * BackgroundAlignH);
				var _backgroundY = round(_y + BackgroundY + (_height - _backgroundHeight) * BackgroundAlignV);

				CE_DrawSpriteNineSlice(_backgroundSprite, _backgroundIndex,
					_backgroundX, _backgroundY, _width, _height, BackgroundTile,
					BackgroundColor, BackgroundAlpha);
				break;
			}
		}
		#endregion Background sprite
	};

	/// @func DrawText()
	/// @desc Draws a text at given position.
	/// @return {CE_GUIWidget} Returns `self`.
	static DrawText = function () {
		Root.SetCurrentFont(Font);
		var _text = RealText;
		var _textScale = FontScale;
		var _textWidth = string_width(_text) * _textScale;
		var _textHeight = string_height(_text) * _textScale;
		var _color = Color;
		var _x = round(RealX + PaddingLeft + (RealWidth - PaddingLeft - PaddingRight - _textWidth) * TextAlignH);
		var _y = round(RealY + PaddingTop + (RealHeight - PaddingTop - PaddingBottom - _textHeight) * TextAlignV);
		draw_text_transformed_color(_x, _y, _text, _textScale, _textScale, 0, _color, _color, _color, _color, Alpha);
		return self;
	};

	/// @func OnDraw()
	/// @desc Implements rendering of the widget.
	static OnDraw = function () {
		DrawBackground();
		DrawText();
	};

	/// @func OnDrawProxy()
	/// @desc Render proxy when the widget is underneath the keyboard.
	static OnDrawProxy = function () {
	};

	/// @func Draw()
	/// @desc Draws the widget, if it is visible.
	/// @return {CE_GUIWidget} Returns `self`.
	static Draw = function () {
		if (!Visible)
		{
			return;
		}
		OnDraw();
		return self;
	};

	/// @func RequestRedraw()
	/// @desc TODO
	/// @return {CE_GUIWidget} Returns `self`.
	static RequestRedraw = function () {
		gml_pragma("forceinline");
		var _current = self;
		while (_current != undefined)
		{
			_current.Redraw = true;
			_current = _current.Parent;
		}
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
/// @return {bool} Returns `true` if the widget exists.
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