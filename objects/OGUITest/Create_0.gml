device_mouse_dbclick_enable(false);

gui = new CE_GUIRoot();
gui.Font = FntGUI;

windowInit = true;

windowSizePrev = [0, 0];

var _container = new CE_GUIContainer();
_container.ContentStyle = CE_EGUIContentStyle.Column;
_container.X = 32;
_container.Y = 32;
_container.Width = 500;
_container.Height = 1920-64;
_container.Overflow = false;
_container.ScrollYEnable = true;
_container.BackgroundColor = c_white;
_container.BackgroundAlpha = 0.5;
_container.SetPadding(32);
gui.AddWidget(_container);

repeat (20)
{
	var _c = new CE_GUIContainer();
	_c.Width = 300;
	_c.Height = 100;
	_c.MarginBottom = 8;
	_c.BackgroundColor = make_color_hsv(random(255), 255, 255);
	_c.BackgroundAlpha = 1.0;
	_c.AddEventListener(CE_GUIClickEvent, method(_c, function (_event) {
		BackgroundColor = make_color_hsv(255 - color_get_hue(BackgroundColor), 255, 255);
	}));
	_container.AddWidget(_c);
}

_container.AddWidget(ce_gui_create_text("String"));
_container.AddWidget(new CE_GUIInput(""));
_container.AddWidget(ce_gui_create_text("Real"));
_container.AddWidget(new CE_GUIInput(0));

repeat (11)
{
	var _c = new CE_GUIContainer();
	_c.Width = 300;
	_c.Height = 100;
	_c.MarginBottom = 8;
	_c.BackgroundColor = make_color_hsv(random(255), 255, 255);
	_c.BackgroundAlpha = 1.0;
	_c.AddEventListener(CE_GUIClickEvent, method(_c, function (_event) {
		BackgroundColor = make_color_hsv(255 - color_get_hue(BackgroundColor), 255, 255);
	}));
	_container.AddWidget(_c);
}