device_mouse_dbclick_enable(false);

gui = new CE_GUIRoot();
gui.Font = FntGUI;

windowInit = true;

windowSizePrev = [0, 0];

//var _vbox = ce_gui_vbox_create(32, -32);
//_vbox.AlignV = CE_EGuiAlign.End;
//gui.Add(_vbox);

//_vbox.Add(new CE_GUIText("String"));
//_vbox.Add(new CE_GUIInput(""));
//_vbox.Add(new CE_GUIText("Real"));
//_vbox.Add(new CE_GUIInput(0));

var _container = new CE_GUIContainer();
_container.ContentStyle = CE_EGuiContentStyle.Column;
_container.X = 32;
_container.Y = 32;
_container.Width = 500;
_container.Height = 1000;
_container.Overflow = false;
_container.ScrollYEnable = true;
_container.BackgroundColor = c_white;
_container.BackgroundAlpha = 1.0;
_container.SetPadding(32);
gui.Add(_container);

repeat (32)
{
	var _c = new CE_GUIContainer();
	_c.Width = 300;
	_c.Height = 100;
	_c.BackgroundColor = make_color_hsv(random(255), 255, 255);
	_c.BackgroundAlpha = 1.0;
	_c.AddEventListener(CE_EGuiEvent.Click, method(_c, function (_event) {
		BackgroundColor = make_color_hsv(255 - color_get_hue(BackgroundColor), 255, 255);
	}));
	_container.Add(_c);
}