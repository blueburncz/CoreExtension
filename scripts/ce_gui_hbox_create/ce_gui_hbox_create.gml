/// @func ce_gui_hbox_create([_x[, _y]])
/// @desc Creates a new horizontal box widget.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
/// @return {CE_GUIContainer} The created widget.
function ce_gui_hbox_create(_x=0, _y=0)
{
	var _w = new CE_GUIContainer();
	_w.ContentStyle = CE_EGuiContentStyle.Row;
	_w.Grow = true;
	_w.X = _x;
	_w.Y = _y;
	return _w;
}