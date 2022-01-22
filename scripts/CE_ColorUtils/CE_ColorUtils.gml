/// @func CE_ColorAlphaToARGB(_color, _alpha)
/// @desc Converts the color and aplha into a ARGB color.
/// @param {real} _color The color.
/// @param {real} _alpha The alpha.
/// @return {real} The ARGB color.
function CE_ColorAlphaToARGB(_color, _alpha)
{
	gml_pragma("forceinline");
	return CE_ColorSwapRB(_color) | ((_alpha * 255) << 24);
}

/// @func CE_ARGBToAlpha(_argb)
/// @desc Converts ARGB color to alpha.
/// @param {real} _argb The ARGB color.
/// @return {real} The alpha.
function CE_ARGBToAlpha(_argb)
{
	gml_pragma("forceinline");
	return (((_argb & $FF000000) >> 24) / 255);
}

/// @func CE_ARGBToColor(_argb)
/// @desc Converts ARGB color to BGR color.
/// @param {real} _argb The ARGB color.
/// @return {real} The BGR color.
function CE_ARGBToColor(_argb)
{
	gml_pragma("forceinline");
	return CE_ColorSwapRB(_argb & $FFFFFF);
}

/// @func CE_ColorInvert(_color)
/// @desc Inverts the color.
/// @param {real} _color The color to invert.
/// @return {real} The inverted color.
function CE_ColorInvert(_color)
{
	gml_pragma("forceinline");
	return make_color_rgb(
		255 - color_get_red(_color),
		255 - color_get_green(_color),
		255 - color_get_blue(_color));
}

/// @func CE_ColorSwapRB(_color)
/// @desc Converts between RGB and BGR color format.
/// @param {real} _color The BGR or RGB color.
/// @return {real} The resulting color.
function CE_ColorSwapRB(_color)
{
	gml_pragma("forceinline");
	return ((_color & $FF0000) >> 16)
		| (_color & $FF00)
		| ((_color & $FF) << 16);
}