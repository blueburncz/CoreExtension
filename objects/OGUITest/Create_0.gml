font_add_enable_aa(true);

//global.fntRoboto = font_add("Fonts/Roboto/Roboto-Regular.ttf", 32, false, false, 32, 128);
//global.fntRobotoLarge = font_add("Fonts/Roboto/Roboto-Regular.ttf", 64, false, false, 32, 128);

//global.fntRobotoMono = font_add("Fonts/Roboto_Mono/RobotoMono-Regular.ttf", 32, false, false, 32, 128);
//global.fntRobotoMonoLarge = font_add("Fonts/Roboto_Mono/RobotoMono-Regular.ttf", 64, false, false, 32, 128);

gui = new CE_GUIRoot();

windowInit = true;

windowSizePrev = [0, 0];

var _vbox = ce_gui_vbox_create(32, 32);
gui.Add(_vbox);

_vbox.Add(new CE_GUIText("String"));
_vbox.Add(new CE_GUIInput(""));
_vbox.Add(new CE_GUIText("Real"));
_vbox.Add(new CE_GUIInput(0));