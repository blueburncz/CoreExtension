/// @func ce_gui_grid_create(_cols, _rows[, _x[, _y[, _width[, _height]]]])
/// @desc Creates a new grid widget.
/// @param {rows} _cols Number of grid columns.
/// @param {rows} _rows Number of grid rows.
/// @param {rows} [_x] Widget's x position. Defaults to 0.
/// @param {rows} [_y] Widget's y position. Defaults to 0.
/// @param {rows} [_width] Widget's width. Defaults to 1.
/// @param {rows} [_height] Widget's height. Defaults to 1.
/// @return {real} The id of the created widget.
function ce_gui_grid_create(_rows, _cols)
{
	var _w = ce_gui_container_create();
	_w[? "contentStyle"] = CE_EGuiContentStyle.Grid;
	_w[? "gridColumns"] = _rows;
	_w[? "gridRows"] = _cols;
	_w[? "x"] = (argument_count > 2) ? argument[2] : 0;
	_w[? "y"] = (argument_count > 3) ? argument[3] : 0;
	_w[? "width"] = (argument_count > 4) ? argument[4] : 1;
	_w[? "height"] = (argument_count > 5) ? argument[5] : 1;
	return _w;
}