/// @func ce_gui_grid_create(_cols, _rows[, _x[, _y[, _width[, _height]]]])
/// @desc Creates a new grid widget.
/// @param {rows} _cols Number of grid columns.
/// @param {rows} _rows Number of grid rows.
/// @param {rows} [_x] Widget's x position. Defaults to 0.
/// @param {rows} [_y] Widget's y position. Defaults to 0.
/// @param {rows} [_width] Widget's width. Defaults to 1.
/// @param {rows} [_height] Widget's height. Defaults to 1.
/// @return {CE_GUIContainer} The created widget.
function ce_gui_grid_create(_rows, _cols)
{
	var _w = new CE_GUIContainer();
	_w.ContentStyle = CE_EGuiContentStyle.Grid;
	_w.GridColumns = _rows;
	_w.GridRows = _cols;
	_w.X = (argument_count > 2) ? argument[2] : 0;
	_w.Y = (argument_count > 3) ? argument[3] : 0;
	_w.Width = (argument_count > 4) ? argument[4] : 1;
	_w.Height = (argument_count > 5) ? argument[5] : 1;
	return _w;
}