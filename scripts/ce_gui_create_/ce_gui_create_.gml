function ce_gui_create_text(_text, _props={})
{
	var _widget = new CE_GUIWidget(_props);
	_widget.Text = _text;
	_widget.Grow = true;
	return _widget;
}

/// @func ce_gui_create_grid(_cols, _rows[, _x[, _y[, _width[, _height]]]])
/// @desc Creates a new grid widget.
/// @param {rows} _cols Number of grid columns.
/// @param {rows} _rows Number of grid rows.
/// @param {rows} [_x] Widget's x position. Defaults to 0.
/// @param {rows} [_y] Widget's y position. Defaults to 0.
/// @param {rows} [_width] Widget's width. Defaults to 1.
/// @param {rows} [_height] Widget's height. Defaults to 1.
/// @return {CE_GUIContainer} The created widget.
function ce_gui_create_grid(_rows, _cols)
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

/// @func ce_gui_hbox_create([_x[, _y]])
/// @desc Creates a new horizontal box widget.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
/// @return {CE_GUIContainer} The created widget.
function ce_gui_create_hbox(_x=0, _y=0)
{
	var _w = new CE_GUIContainer();
	_w.ContentStyle = CE_EGuiContentStyle.Row;
	_w.Grow = true;
	_w.X = _x;
	_w.Y = _y;
	return _w;
}

/// @func ce_gui_create_sprite(_sprite[, _index[, _x[, _y[, _color[, _alpha]]]]])
/// @desc Creates a new widget from the sprite.
/// @param {real} _sprite The sprite.
/// @param {real} [_index] The sprite subimage index. Defaults to 0.
/// @param {real} [_x] The x position of the sprite. Defaults to 0.
/// @param {real} [_y] The y position of the sprite. Defaults to 0.
/// @param {real} [_color] The color to blend the sprite with. Defaults
/// to `c_white`.
/// @param {real} [_alpha] The sprite alpha. Defaults to 1.
/// @return {CE_GUIWidget} The created widget.
function ce_gui_create_sprite(_sprite, _index=0, _x=0, _y=0, _color=c_white, _alpha=1)
{
	var _w = new CE_GUIWidget();
	_w.BackgroundSprite = _sprite;
	_w.BackgroundIndex = _index;
	_w.X = _x;
	_w.Y = _y;
	_w.BackgroundSpriteBlend = _color;
	_w.BackgroundSpriteAlpha = _alpha;
	_w.Width = sprite_get_width(_sprite);
	_w.Height = sprite_get_height(_sprite);
	return _w;
}

/// @func ce_gui_create_vbox([_x[, _y]])
/// @desc Creates a new vertical box widget.
/// @param {real} [_x] The x position. Defaults to 0.
/// @param {real} [_y] The y position. Defaults to 0.
/// @return {CE_GUIContainer} The created widget.
function ce_gui_create_vbox(_x=0, _y=0)
{
	var _w = new CE_GUIContainer();
	_w.ContentStyle = CE_EGuiContentStyle.Column;
	_w.Grow = true;
	_w.X = _x;
	_w.Y = _y;
	return _w;
}