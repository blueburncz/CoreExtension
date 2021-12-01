var _windowWidth = window_get_width();
var _windowHeight = window_get_height();

if (windowInit
	|| _windowWidth != windowSizePrev[0]
	|| _windowHeight != windowSizePrev[1])
{
	var _scale;
	if (_windowWidth > _windowHeight)
	{
		_scale = ce_scale_keep_aspect(
			_windowWidth,
			_windowHeight,
			CE_DESIGN_SCREEN_WIDTH,
			CE_DESIGN_SCREEN_HEIGHT);
	}
	else
	{
		_scale = ce_scale_keep_aspect(
			_windowWidth,
			_windowHeight,
			CE_DESIGN_SCREEN_HEIGHT,
			CE_DESIGN_SCREEN_WIDTH);
	}

	display_set_gui_size(_windowWidth, _windowHeight);
	display_set_gui_maximize(_scale, _scale);
	gui.Scale = _scale;

	windowSizePrev = [
		_windowWidth,
		_windowHeight
	];

	windowInit = false;
}

gui.OnUpdate();