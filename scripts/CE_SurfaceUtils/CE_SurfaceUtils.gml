/// @func CE_SurfaceBlur(_target, _work, _scale)
/// @desc Blurs the target surface.
/// @param {surface} _target The surface to be blurred.
/// @param {surface/undefined} _work A working surface. Must have the same size
/// as the target surface. If `undefined`, then a temporary surface is created.
/// @param {real} _scale The scale of the blur kernel.
function CE_SurfaceBlur(_target, _work, _scale)
{
	var _width = surface_get_width(_target);
	var _height = surface_get_height(_target);
	var _isTemp = false;

	if (_work == undefined)
	{
		_work = surface_create(_width, _height);
		_isTemp = true;
	}

	static _shader = CE_ShGaussianBlur;
	static _uTexel = shader_get_uniform(_shader, "u_vTexel");
	var _texelW = _scale / _width;
	var _texelH = _scale / _height;

	surface_set_target(_work);
	draw_clear_alpha(0, 0);
	shader_set(_shader);
	shader_set_uniform_f(_uTexel, _texelW, 0.0);
	draw_surface(_target, 0, 0);
	shader_reset();
	surface_reset_target();

	surface_set_target(_target);
	draw_clear_alpha(0, 0);
	shader_set(_shader);
	shader_set_uniform_f(_uTexel, 0.0, _texelH);
	draw_surface(_work, 0, 0);
	shader_reset();
	surface_reset_target();

	if (_isTemp)
	{
		surface_free(_work);
	}
}

/// @func CE_SurfaceCheck(_surface, _width, _height)
/// @desc Checks whether the surface exists and if it has correct size. Broken
/// surfaces are recreated. Surfaces of wrong size are resized.
/// @param {surface} _surface The surface to check.
/// @param {real} _width The desired width of the surface.
/// @param {real} _height The desired height of the surface.
/// @return {surface} The surface.
function CE_SurfaceCheck(_surface, _width, _height)
{
	_width = max(round(_width), 1);
	_height = max(round(_height), 1);

	if (!surface_exists(_surface))
	{
		return surface_create(_width, _height);
	}

	if (surface_get_width(_surface) != _width
		|| surface_get_height(_surface) != _height)
	{
		surface_resize(_surface, _width, _height);
	}

	return _surface;
}

/// @func CE_SurfaceClone(_surface)
/// @desc Creates a copy of a surface.
/// @param {real} _surface The surface to create a copy of.
/// @return {surface} The created surface.
function CE_SurfaceClone(_surface)
{
	var _clone = surface_create(
		surface_get_width(_surface),
		surface_get_height(_surface));
	surface_copy(_clone, 0, 0, _surface);
	return _clone;
}

/// @func CE_SurfaceCreateFromSprite(sprite, index)
/// @desc Creates a surface from the sprite.
/// @param {sprite} _sprite The sprite.
/// @param {real} _index The sprite subimage index.
/// @return {surface} The created surface.
function CE_SurfaceCreateFromSprite(_sprite, _index)
{
	var _surface = surface_create(sprite_get_width(_sprite), sprite_get_height(_sprite));
	surface_set_target(_surface);
	draw_clear_alpha(0, 0);
	draw_sprite(_sprite, _index, 0, 0);
	surface_reset_target();
	return _surface;
}

/// @func CE_SurfaceClearColor(_color, _alpha)
/// @desc Clears color of the current render target without clearing its
/// depth buffer.
/// @param {uint} _color The color to clear the target with.
/// @param {real} _alpha The alpha to clear the target with.
function CE_SurfaceClearColor(_color, _alpha)
{
	var _surface = surface_get_target();
	gpu_push_state();
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	gpu_set_ztestenable(false);
	gpu_set_zwriteenable(false);
	shader_set(CE_ShClearColor);
	shader_set_uniform_f(shader_get_uniform(CE_ShClearColor, "u_vColor"),
		color_get_red(_color) / 255,
		color_get_green(_color) / 255,
		color_get_blue(_color) / 255,
		_alpha);
	draw_rectangle(0, 0, surface_get_width(_surface), surface_get_height(_surface), false);
	shader_reset();
	gpu_pop_state();
}

/// @func CE_SurfaceCopy(_source, _target)
/// @desc Renders contents of one surface to another without blending (affected
/// pixels in the target surface are completely overwritten with ones from the
/// source surface).
/// @param {surface} _source The surface to be rendered.
/// @param {surface} _target The surface to render into.
function CE_SurfaceCopy(_source, _target)
{
	surface_set_target(_target);
	gpu_push_state();
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	gpu_set_ztestenable(false);
	gpu_set_zwriteenable(false);
	draw_surface(_source, 0, 0);
	gpu_pop_state();
	surface_reset_target();
}