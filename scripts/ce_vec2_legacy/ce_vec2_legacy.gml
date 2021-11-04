/// @func ce_vec2_create([_x[, _y]])
/// @desc Creates a new 2D vector.
/// @param {real} [_x] The first vector component. Defalts to 0.
/// @param {real} [_y] The second vector component. Defaults to `_x`.
/// @return {real[2]} The created vector.
/// @note One could also just write `[x, y]`, which would give the same result.
function ce_vec2_create()
{
	gml_pragma("forceinline");
	var _x = (argument_count > 0) ? argument[0] : 0;
	var _y = (argument_count > 1) ? argument[1] : _x;
	return [_x, _y];
}

/// @func ce_vec2_create_barycentric(_v1, _v2, _v3, _f, _g)
/// @desc Creates a new vector using barycentric coordinates, following formula
/// `_v1 + _f(_v2-_v1) + _g(_v3-_v1)`.
/// @param {real[2]} _v1 The first point of triangle.
/// @param {real[2]} _v2 The second point of triangle.
/// @param {real[2]} _v3 The third point of triangle.
/// @param {real} _f The first weighting factor.
/// @param {real} _g The second weighting factor.
/// @return {real[2]} The created vector.
function ce_vec2_create_barycentric(_v1, _v2, _v3, _f, _g)
{
	gml_pragma("forceinline");
	var _v10 = _v1[0];
	var _v11 = _v1[1];
	return [
		_v10 + _f*(_v2[0]-_v10) + _g*(_v3[0]-_v10),
		_v11 + _f*(_v2[1]-_v11) + _g*(_v3[1]-_v11)
	];
}

/// @func ce_vec2_create_from_array(_array[, _index])
/// @desc Creates a new 2D vector, taking its components from the array, starting
/// from given index.
/// @param {real[]} _array The array to take the values from.
/// @param {uint} [_index] The index to start taking the values from.
/// @return {real[2]} The created vector.
/// @example
/// ```gml
/// var _arr = [1, 2, 3, 4, 5, 6];
/// var _vec = ce_vec2_from_array(_arr, 3); // => [4, 5]
/// ```
function ce_vec2_create_from_array(_array)
{
	gml_pragma("forceinline");
	var _index = (argument_count > 1) ? argument[1] : 0;
	return [
		_array[_index],
		_array[_index + 1],
	];
}

/// @func ce_vec2_create_from_buffer(_buffer, _type)
/// @desc Creates a new 2D vector, taking its components from the buffer.
/// @param {buffer} _buffer The buffer to take the values from.
/// @param {uint} _type The type of values in the buffer. Use one of the
/// `buffer_` type constants.
/// @return {real[2]} The created vector.
function ce_vec2_create_from_buffer(_buffer, _type)
{
	gml_pragma("forceinline");
	var _vec = array_create(2);
	_vec[@ 0] = buffer_read(_buffer, _type);
	_vec[@ 1] = buffer_read(_buffer, _type);
	return _vec;
}

/// @func ce_vec2_abs(_v)
/// @desc Sets vector's components to their absolute value.
/// @param {real[2]} _v The vector.
function ce_vec2_abs(_v)
{
	gml_pragma("forceinline");
	_v[@ 0] = abs(_v[0]);
	_v[@ 1] = abs(_v[1]);
}

/// @func ce_vec2_add(_v1, _v2)
/// @desc Adds vectors `_v1`, `_v2` and stores the result into `_v1`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
function ce_vec2_add(_v1, _v2)
{
	gml_pragma("forceinline");
	_v1[@ 0] += _v2[0];
	_v1[@ 1] += _v2[1];
}

/// @func ce_vec2_ceil(_v)
/// @desc Ceils each component of the vector.
/// @param {real[2]} _v The vector to ceil.
function ce_vec2_ceil(_v)
{
	gml_pragma("forceinline");
	_v[@ 0] = ceil(_v[0]);
	_v[@ 1] = ceil(_v[1]);
}

/// @func ce_vec2_clamp_length(_v, _min, _max)
/// @desc Clamps vector's length between `_min` and `_max`.
/// @param {real[2]} _v The vector.
/// @param {real} _min The minimum vector length.
/// @param {real} _max The maximum vector length.
function ce_vec2_clamp_length(_v, _min, _max)
{
	gml_pragma("forceinline");
	var _length = ce_vec2_length(_v);
	ce_vec2_normalize(_v);
	ce_vec2_scale(_v, clamp(_length, _min, _max));
}

/// @func ce_vec2_clone(_v)
/// @desc Creates a clone of the vector.
/// @param {real[2]} _v The vector.
/// @return {real[2]} The created clone.
function ce_vec2_clone(_v)
{
	gml_pragma("forceinline");
	var _clone = array_create(2, 0);
	array_copy(_clone, 0, _v, 0, 2);
	return _clone;
}

/// @func ce_vec2_dot(_v1, _v2)
/// @desc Gets the dot product of vectors `_v1` and `_v2`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @return {real} The dot product.
function ce_vec2_dot(_v1, _v2)
{
	gml_pragma("forceinline");
	return (_v1[0] * _v2[0]
		+ _v1[1] * _v2[1]);
}

/// @func ce_vec2_equals(_v1, _v2)
/// @desc Gets whether vectors `_v1` and `_v2` are equal.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @return {bool} Returns `true` if the vectors are equal.
function ce_vec2_equals(_v1, _v2)
{
	gml_pragma("forceinline");
	return (_v1[0] == _v2[0]
		&& _v1[1] == _v2[1]);
}

/// @func ce_vec2_floor(_v)
/// @desc Floors each component of the vector.
/// @param {real[2]} _v The vector to floor.
function ce_vec2_floor(_v)
{
	gml_pragma("forceinline");
	_v[@ 0] = floor(_v[0]);
	_v[@ 1] = floor(_v[1]);
}

/// @func ce_vec2_frac(_v)
/// @desc Sets each component of the input vector to its decimal part.
/// @param {real[2]} _v The input vector.
function ce_vec2_frac(_v)
{
	gml_pragma("forceinline");
	_v[@ 0] = frac(_v[0]);
	_v[@ 1] = frac(_v[1]);
}

/// @func ce_vec2_length(_v)
/// @desc Gets length of the vector.
/// @param {real[2]} _v The vector.
/// @return {real} The vector's length.
function ce_vec2_length(_v)
{
	gml_pragma("forceinline");
	var _v0 = _v[0];
	var _v1 = _v[1];
	return sqrt(_v0 * _v0
		+ _v1 * _v1);
}

/// @func ce_vec2_lengthsqr(_v)
/// @desc Gets squared length of the vector.
/// @param {real[2]} _v The vector.
/// @return {real} The vector's squared length.
function ce_vec2_lengthsqr(_v)
{
	gml_pragma("forceinline");
	var _v0 = _v[0];
	var _v1 = _v[1];
	return (_v0 * _v0
		+ _v1 * _v1);
}

/// @func ce_vec2_lerp(_v1, _v2, _s)
/// @desc Linearly interpolates between vectors `_v1`, `_v2` and stores the
/// resulting vector into `_v1`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @param {real} _s The interpolation factor.
function ce_vec2_lerp(_v1, _v2, _s)
{
	gml_pragma("forceinline");
	_v1[@ 0] = lerp(_v1[0], _v2[0], _s);
	_v1[@ 1] = lerp(_v1[1], _v2[1], _s);
}

/// @func ce_vec2_max_component(_v)
/// @desc Gets the largest component of the vector.
/// @param {real[2]} _v The vector.
/// @return {real} The vetor's largest component.
/// @example
/// Here the `_max` variable would be equal to `2`.
/// ```gml
/// var _vec = [1, 2];
/// var _max = ce_vec2_max_component(_vec);
/// ```
function ce_vec2_max_component(_v)
{
	gml_pragma("forceinline");
	return max(_v[0], _v[1]);
}

/// @func ce_vec2_maximize(v1, v2)
/// @desc Gets a vector that is made up of the largest components of the
/// vectors `_v1`, `_v2` and stores it into `_v1`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @example
/// This would make the vector `_v1` equal to `[2, 4]`.
/// ```gml
/// var _v1 = [1, 4];
/// var _v2 = [2, 3];
/// ce_vec2_maximize(_v1, _v2);
/// ```
function ce_vec2_maximize(_v1, _v2)
{
	gml_pragma("forceinline");
	_v1[@ 0] = max(_v1[0], _v2[0]);
	_v1[@ 1] = max(_v1[1], _v2[1]);
}

/// @func ce_vec2_min_component(_v)
/// @desc Gets the smallest component of the vector.
/// @param {real[2]} _v The vector.
/// @return {real} The vetor's smallest component.
/// @example
/// Here the `_min` variable would be equal to `1`.
/// ```gml
/// var _vec = [1, 2];
/// var _min = ce_vec2_min_component(_vec);
/// ```
function ce_vec2_min_component(_v)
{
	gml_pragma("forceinline");
	return min(_v[0], _v[1]);
}

/// @func ce_vec2_minimize(_v1, _v2)
/// @desc Gets a vector that is made up of the smallest components of the
/// vectors `_v1`, `_v2` and stores it into `_v1`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @example
/// This would make the vector `_v1` equal to `[1, 3]`.
/// ```gml
/// var _v1 = [1, 4];
/// var _v2 = [2, 3];
/// ce_vec2_minimize(_v1, _v2);
/// ```
function ce_vec2_minimize(_v1, _v2)
{
	gml_pragma("forceinline");
	_v1[@ 0] = min(_v1[0], _v2[0]);
	_v1[@ 1] = min(_v1[1], _v2[1]);
}

/// @func ce_vec2_multiply(_v1, _v2)
/// @desc Multiplies the vectors `_v1`, `_v2` componentwise and stores the result
/// into `_v1`.
/// @param {real[2]} _v1 The first vector.
/// @param {real[2]} _v2 The second vector.
/// @example
/// This would make the vector `_v1` equal to `[3, 8]`.
/// ```gml
/// var _v1 = [1, 2];
/// var _v2 = [3, 4];
/// ce_vec2_multiply(_v1, _v2);
/// ```
function ce_vec2_multiply(_v1, _v2)
{
	gml_pragma("forceinline");
	_v1[@ 0] *= _v2[0];
	_v1[@ 1] *= _v2[1];
}

/// @func ce_vec2_normalize(_v)
/// @desc Normalizes the vector (makes the vector's length equal to `1`).
/// @param {real[2]} _v The vector to be normalized.
function ce_vec2_normalize(_v)
{
	gml_pragma("forceinline");
	var _lengthSqr = ce_vec2_lengthsqr(_v);
	if (_lengthSqr > 0)
	{
		var _n = 1 / sqrt(_lengthSqr);
		_v[@ 0] *= _n;
		_v[@ 1] *= _n;
	}
}

/// @func ce_vec2_reflect(_v, _n)
/// @desc Reflects the incident vector `_v` off the normal vector `_n`.
/// @param {real[2]} _v The incident vector.
/// @param {real[2]} _n The normal vector.
function ce_vec2_reflect(_v, _n)
{
	gml_pragma("forceinline");
	var _dot = ce_vec2_dot(_v, _n);
	_v[@ 0] = _v[0] - 2 * _dot * _n[0];
	_v[@ 1] = _v[1] - 2 * _dot * _n[1];
}

/// @func ce_vec2_scale(_v, _s)
/// @desc Scales the vector's components by the given value.
/// @param {real[2]} _v The vector.
/// @param {real} _s The value to scale the components by.
function ce_vec2_scale(_v, _s)
{
	gml_pragma("forceinline");
	_v[@ 0] *= _s;
	_v[@ 1] *= _s;
}

/// @func ce_vec2_subtract(_v1, _v2)
/// @desc Subtracts vector `_v2` from `_v1` and stores the result into `_v1`.
/// @param {real[2]} _v1 The vector to subtract from.
/// @param {real[2]} _v2 The vector to subtract.
function ce_vec2_subtract(_v1, _v2)
{
	gml_pragma("forceinline");
	_v1[@ 0] -= _v2[0];
	_v1[@ 1] -= _v2[1];
}

/// @func ce_vec2_transform(_v, _m)
/// @desc Transforms a 4D vector `[_vX, _vY, 0, 1]` by the matrix `_m` and stores
/// `[x, y]` of the resulting vector to `_v`.
/// @param {real[2]} _v The vector to transform.
/// @param {real[2]} _m The transform matrix.
function ce_vec2_transform(_v, _m)
{
	gml_pragma("forceinline");
	var _w = [_v[0], _v[1], 0, 1];
	ce_vec4_transform(_w, _m);
	_v[@ 0] = _w[0];
	_v[@ 1] = _w[1];
}