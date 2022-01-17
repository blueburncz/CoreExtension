/// @func CE_GUIContainer([_props])
/// @extends CE_GUIWidget
/// @desc A container of widgets.
/// @param {struct} [_props]
function CE_GUIContainer(_props={})
	: CE_GUIWidget(_props) constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Widget = {
		OnCleanUp: OnCleanUp,
		UpdatePosition: UpdatePosition,
		Update: Update,
	};

	/// @var {ds_list<CE_GUIWidget>}
	/// @readonly
	Widgets = ds_list_create();

	/// @var {bool}
	Overflow = ce_struct_get(_props, "Overflow", false);

	/// @var {surface}
	/// @readonly
	Surface = noone;

	/// @var {CE_EGUIContentStyle}
	ContentStyle = ce_struct_get(_props, "ContentStyle", CE_EGUIContentStyle.Default);

	/// @var {uint}
	GridColumns = ce_struct_get(_props, "GridColumns", 1);

	/// @var {uint}
	GridRows = ce_struct_get(_props, "GridRows", 1);

	/// @var {real}
	SpacingH = ce_struct_get(_props, "SpacingH", 0);

	/// @var {real}
	SpacingV = ce_struct_get(_props, "SpacingV", 0);

	/// @var {real}
	/// @readonly
	ContentW = 0;

	/// @var {real}
	/// @readonly
	ContentH = 0;

	/// @var {real}
	/// @readonly
	ScrollX = 0;

	/// @var {real}
	/// @readonly
	ScrollY = 0;

	/// @var {bool}
	ScrollXEnable = ce_struct_get(_props, "ScrollXEnable", false);

	/// @var {bool}
	ScrollYEnable = ce_struct_get(_props, "ScrollYEnable", false);

	AddEventListener(CE_GUIChangeEvent, method(self, OnChange));
	AddEventListener(CE_GUIDragEvent, method(self, OnDrag));

	/// @func SetSpacing(_h[, _v])
	/// @desc
	/// @param {real} _h
	/// @param {real} [_v]
	/// @return {CE_GUIContainer} Return `self`.
	static SetSpacing = function (_h) {
		gml_pragma("forceinline");
		SpacingH = _h;
		SpacingV = (argument_count > 1) ? argument[1] : _h;
		return self;
	};

	/// @func AddWidget(_widget)
	/// @desc Adds the widget to the container.
	/// @param {CE_GUIWidget} _widget The widget to add.
	/// @return {CE_GUIContainer} Return `self`.
	static AddWidget = function (_widget) {
		ce_assert(_widget.Root == undefined, "Widget is already added to a GUI.");
		ce_assert(_widget.Parent == undefined, "Widget already has a parent.");
		ce_assert(Root != undefined, "Parent must be added to a GUI.");
		_widget.Root = Root;
		_widget.Parent = self;
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

	static OnChange = function (_event) {
		Redraw = true;
	};

	/// @func OnDrag(_event)
	/// @param {CE_GUIDragEvent} _event The event.
	static OnDrag = function (_event) {
		var _redraw = false;

		if (ScrollXEnable)
		{
			var _scrollXOld = ScrollX;
			var _scrollX = clamp(_scrollXOld + _event.DiffX,
				0, max(ContentW - RealWidth, 0));
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
				0, max(ContentH - RealHeight, 0));
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

	static UpdatePosition = function (_mouseX, _mouseY) {
		method(self, Super_Widget.UpdatePosition)(_mouseX, _mouseY);

		if (!Visible)
		{
			return self;
		}

		var _root = Root;
		var _x = RealX;
		var _y = RealY;
		var _width = RealWidth;
		var _height = RealHeight;

		var _scrollX = _x - ScrollX;
		var _scrollY = _y - ScrollY;

		var _contentStyle = ContentStyle;
		var _contentW = 0;
		var _contentH = 0;
		var _spacingH = SpacingH;
		var _spacingV = SpacingV;

		var _paddingLeft = PaddingLeft;
		var _paddingTop = PaddingTop;
		var _paddingRight = PaddingRight;
		var _paddingBottom = PaddingBottom;

		var _drawX = _paddingLeft;
		var _drawY = _paddingTop;
		var _stepX = 0;
		var _stepY = 0;

		var _contentMaxW = _width - _paddingLeft - _paddingRight;
		var _contentMaxH = _height - _paddingTop - _paddingBottom;

		if (_contentStyle == CE_EGUIContentStyle.Grid)
		{
			_stepX = _contentMaxW / GridColumns;
			_stepY = _contentMaxH / GridRows;
		}
		else
		{
			_stepX = _spacingH;
			_stepY = _spacingV;
		}

		var _widgets = Widgets;
		var _widgetCount = ds_list_size(_widgets);

		for (var i = 0; i < _widgetCount; ++i)
		{
			var _widget = _widgets[| i];

			if (!_widget.Visible)
			{
				continue;
			}

			_widget.PrecomputeSize();

			var _widgetRealX = 0;
			var _widgetRealY = 0;
			var _widgetPosition = _widget.Position;
			var _widgetWidth = (_widget.WidthRelative)
				? _widget.Width * _contentMaxW
				: _widget.RealWidth;
			var _widgetHeight = (_widget.HeightRelative)
				? _widget.Height * _contentMaxH
				: _widget.RealHeight;

			switch (_widgetPosition)
			{
			case CE_EGUIPosition.Scroll:
				var __xReal, __yReal;

				if (_contentStyle == CE_EGUIContentStyle.Grid)
				{
					__xReal = _drawX + _widget.X + (_stepX - _widgetWidth) * _widget.AlignH;
					__yReal = _drawY + _widget.Y + (_stepY - _widgetHeight) * _widget.AlignV;
				}
				else
				{
					_drawX += _widget.MarginLeft;
					_drawY += _widget.MarginTop;
					__xReal = _drawX + _widget.X + (_contentMaxW - _widgetWidth) * _widget.AlignH;
					__yReal = _drawY + _widget.Y + (_contentMaxH - _widgetHeight) * _widget.AlignV;
					_drawX += _widget.MarginRight;
					_drawY += _widget.MarginBottom;
				}

				_widgetRealX = _scrollX + __xReal;
				_widgetRealY = _scrollY + __yReal;

				switch (_contentStyle)
				{
				case CE_EGUIContentStyle.Column:
					_drawY += _widgetHeight + _spacingV;
					_contentW = max(__xReal + _widgetWidth, _contentW);
					_contentH = max(__yReal + _widgetHeight, _contentH);
					break;

				case CE_EGUIContentStyle.Default:
					_contentW = max(__xReal + _widgetWidth, _contentW);
					_contentH = max(__yReal + _widgetHeight, _contentH);
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
					_drawX += _widgetWidth + _spacingH;
					_contentW = max(__xReal + _widgetWidth, _contentW);
					_contentH = max(__yReal + _widgetHeight, _contentH);
					break;
				}
				break;

			case CE_EGUIPosition.Fixed:
				_widgetRealX = _x + _widget.X + (_width - _widgetWidth) * _widget.AlignH;
				_widgetRealY = _y + _widget.Y + (_height - _widgetHeight) * _widget.AlignV;
				break;

			default:
				ce_assert(false, "Invalid widget position property");
			}

			_widget.RealX = _widgetRealX;
			_widget.RealY = _widgetRealY;
			_widget.RealWidth = _widgetWidth;
			_widget.RealHeight = _widgetHeight;
			_widget.UpdatePosition(_mouseX + _x - _widgetRealX, _mouseY + _y - _widgetRealY);
		}

		_contentW += _paddingRight;
		_contentH += _paddingBottom;

		ContentW = _contentW;
		ContentH = _contentH;

		if (Grow
			&& (_width != _contentW
			|| _height != _contentH))
		{
			RealWidth = _contentW;
			RealHeight = _contentH;
			if (_root != undefined)
			{
				_root.FixPositioning = true;
			}
		}

		return self;
	};

	static Update = function () {
		method(self, Super_Widget.Update)();
		var _widgets = Widgets;
		var _index = 0;
		repeat (ds_list_size(_widgets))
		{
			_widgets[| _index++].Update();
		}
		return self;
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
		var _x = RealX;
		var _y = RealY;
		var _width = RealWidth;
		var _height = RealHeight;
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
				if (_parent != undefined)
				{
					_parent.Redraw = true;
				}
				Redraw = false;
				surface_set_target(_surface);
				draw_clear_alpha(0, 0);
				gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
				matrix_stack_push(matrix_get(matrix_world));
				matrix_set(matrix_world, matrix_build(-_x, -_y, 0, 0, 0, 0, 1, 1, 1));
				DrawBackground();
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
			DrawBackground();
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

		if (Surface != noone
			&& surface_exists(Surface))
		{
			surface_free(Surface);
		}
	};
}