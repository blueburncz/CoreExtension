/// @func ce_draw_rectangle(_x, _y, _width, _height[, _color[, _alpha]])
/// @desc Draws a rectangle of the given size and color at the given position.
/// @param {real} _x The x position to draw the rectangle at.
/// @param {real} _y The y position to draw the rectangle at.
/// @param {real} _width The width of the rectangle.
/// @param {real} _height The height of the rectangle.
/// @param {uint} [_color] The color of the rectangle. Defaults to `c_white`.
/// @param {real} [_alpha] The alpha of the rectangle. Defaults to 1.
function ce_draw_rectangle(_x, _y, _width, _height)
{
	gml_pragma("forceinline");
	draw_sprite_ext(CE_SprRectangle, 0, _x, _y, _width, _height, 0,
		(argument_count > 4) ? argument[4] : c_white,
		(argument_count > 5) ? argument[5] : 1);
}

/// @func ce_draw_sprite_nine_slice(_sprite, _subimage, _x, _y, _width, _height, _tiled[, _color[, _alpha]])
/// @desc Draws a nine-slice sprite.
/// @param {real} _sprite The nine slice sprite to draw.
/// @param {real} _subimage The subimage of the sprite to draw.
/// @param {real} _x The x position to draw the sprite at.
/// @param {real} _y The y position to draw the sprite at.
/// @param {real} _width The width to which the sprite should be stretched.
/// @param {real} _height The height to which the sprite should be stretched.
/// @param {bool} _tiled True to tile the sprite of false to stretch.
/// @param {real} [_color] The color to blend the sprite with. Defaults to
/// `c_white`.
/// @param {real} [_alpha] The opacity of the sprite. Defaults to 1.
/// @note Currently it is not supported to use width and height smaller than
/// the size of the original image.
function ce_draw_sprite_nine_slice(_sprite, _subimage, _x, _y, _width, _height, _tiled)
{
	var _color = (argument_count > 7) ? argument[7] : c_white;
	var _alpha = (argument_count > 8) ? argument[8] : 1;

	var _spriteWidth = sprite_get_width(_sprite);
	var _spriteHeight = sprite_get_height(_sprite);

	var _sliceX = floor(_spriteWidth / 3);
	var _sliceX2 = _sliceX * 2;
	var _sliceY = floor(_spriteHeight / 3);
	var _sliceY2 = _sliceY * 2;

	_width = max(_width, _sliceX2);
	_height = max(_height, _sliceY2);

	var _widthInner = _width - _sliceX2;
	var _heightInner = _height - _sliceY2;

	var _scaleHor = _widthInner / _sliceX;
	var _scaleVer = _heightInner / _sliceY;

	var _centerX = _x + _sliceX;
	var _centerY = _y + _sliceY;
	var _rightX = _x + _width - _sliceX;
	var _bottomY = _y + _height - _sliceY;

	if (!_tiled)
	{
		// Top edge
		draw_sprite_part_ext(_sprite, _subimage, _sliceX, 0,
			_sliceX, _sliceY, _centerX, _y, _scaleHor, 1, _color, _alpha);

		// Left edge
		draw_sprite_part_ext(_sprite, _subimage, 0, _sliceY,
			_sliceX, _sliceY, _x, _centerY, 1, _scaleVer, _color, _alpha);

		// Center
		draw_sprite_part_ext(_sprite, _subimage, _sliceX, _sliceY,
			_sliceX, _sliceY, _centerX, _centerY, _scaleHor, _scaleVer, _color, _alpha);

		// Right edge
		draw_sprite_part_ext(_sprite, _subimage, _sliceX2, _sliceY,
			_sliceX, _sliceY, _rightX, _centerY, 1, _scaleVer, _color, _alpha);

		// Bottom edge
		draw_sprite_part_ext(_sprite, _subimage, _sliceX, _sliceY2,
			_sliceX, _sliceY, _centerX, _bottomY, _scaleHor, 1, _color, _alpha);
	}
	else
	{
		var _drawX = _centerX;

		while (_drawX < _centerX + _widthInner)
		{
			var _drawY = _centerY;
			while (_drawY < _centerY + _heightInner)
			{
				// Center
				draw_sprite_part_ext(_sprite, _subimage, _sliceX, _sliceY,
					_sliceX, _sliceY, _drawX, _drawY, 1, 1, _color, _alpha);
				_drawY += _sliceY;
			}
			_drawX += _sliceX;
		}

		_drawX = _centerX;

		var _drawY = _centerY;
		while (_drawY < _centerY + _heightInner)
		{
			// Left edge
			draw_sprite_part_ext(_sprite, _subimage, 0, _sliceY,
				_sliceX, _sliceY, _x, _drawY, 1, 1, _color, _alpha);
			// Right edge
			draw_sprite_part_ext(_sprite, _subimage, _sliceX2, _sliceY,
				_sliceX, _sliceY, _rightX, _drawY, 1, 1, _color, _alpha);
			_drawY += _sliceY;
		}

		while (_drawX < _x + _width - _sliceX)
		{
			// Top edge
			draw_sprite_part_ext(_sprite, _subimage, _sliceX, 0,
				_sliceX, _sliceY, _drawX, _y, 1, 1, _color, _alpha);

			// Bottom edge
			draw_sprite_part_ext(_sprite, _subimage, _sliceX, _sliceY2,
				_sliceX, _sliceY, _drawX, _bottomY, 1, 1, _color, _alpha);

			_drawX += _sliceX;
		}
	}

	// Top left corner
	draw_sprite_part_ext(_sprite, _subimage, 0, 0,
		_sliceX, _sliceY, _x, _y, 1, 1, _color, _alpha);

	// Top right corner
	draw_sprite_part_ext(_sprite, _subimage, _sliceX2, 0,
		_sliceX, _sliceY, _rightX, _y, 1, 1, _color, _alpha);

	// Bottom left corner
	draw_sprite_part_ext(_sprite, _subimage, 0, _sliceY2,
		_sliceX, _sliceY, _x, _bottomY, 1, 1, _color, _alpha);

	// Bottom right corner
	draw_sprite_part_ext(_sprite, _subimage, _sliceX2, _sliceY2,
		_sliceX, _sliceY, _rightX, _bottomY, 1, 1, _color, _alpha);
}

/// @func ce_draw_text_shadow(_x, _y, _string[, _color[, _shadow]])
/// @desc Draws a text with a shadow.
/// @param {real} _x The x position to draw the text at.
/// @param {real} _y The y position to draw the text at.
/// @param {string} _string The text to draw.
/// @param {uint} [_color] The color of the text. Defaults to `c_white`.
/// @param {uint} [_shadow] The color of the shadow. Defaults to `c_black`.
function ce_draw_text_shadow(_x, _y, _string)
{
	var _color = (argument_count > 3) ? argument[3] : c_white;
	var _shadow = (argument_count > 4) ? argument[4] : c_black;
	draw_text_color(_x + 1, _y + 1, _string, _shadow, _shadow, _shadow, _shadow, 1);
	draw_text_color(_x, _y, _string, _color, _color, _color, _color, 1);
}