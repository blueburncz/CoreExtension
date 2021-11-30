/// @func ce_gui_hbox_create([_x[, _y]])
/// @desc Creates a new horizontal box widget.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
/// @return {real} The id of the created widget.
function ce_gui_hbox_create(_x=0, _y=0)
{
	var _w = ce_gui_container_create();
	_w[? "contentStyle"] = CE_EGuiContentStyle.Row;
	_w[? "grow"] = true;
	_w[? "x"] = _x;
	_w[? "y"] = _y;
	return _w;
}