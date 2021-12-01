font_add_enable_aa(true);

gui = new CE_GUIRoot();
gui.Font = FntGUI;

windowInit = true;

windowSizePrev = [0, 0];

var _vbox = ce_gui_vbox_create(32, -32);
_vbox.AlignV = CE_EGuiAlign.End;
gui.Add(_vbox);

_vbox.Add(new CE_GUIText("String"));
_vbox.Add(new CE_GUIInput(""));
_vbox.Add(new CE_GUIText("Real"));
_vbox.Add(new CE_GUIInput(0));