/// @func ce_byte_array_to_hex(_bytes)
/// @desc Converts an array of number between 0..255 into a string of
/// hexadecimal representations of each number.
/// @param {array} _bytes The array with numbers.
/// @return {string} The resulting string.
function ce_byte_array_to_hex(_bytes)
{
	var _str = "";
	var _size = array_length(_bytes);
	for (var i = 0; i < _size; ++i)
	{
		_str += ce_byte_to_hex(_bytes[i]);
	}
	return _str;
}

/// @func ce_byte_to_hex(_byte)
/// @desc Converts a number in range 0..255 into a hexadecimal representation.
/// @param {real} _byte The number to convert.
/// @return {string} The hexadecimal representation.
function ce_byte_to_hex(_byte)
{
	gml_pragma("forceinline");
	return (ce_nibble_to_hex(_byte & 0xF) + ce_nibble_to_hex((_byte & 0xF0) >> 4));
}

/// @func ce_nibble_to_hex(_nibble)
/// @desc Converts a number in range 0..15 into its hexadecimal representation.
/// @param {real} _nibble The number to convert.
/// @return {string} The hexadecimal representation.
function ce_nibble_to_hex(_nibble)
{
	gml_pragma("forceinline");
	static _nibble_to_hex = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
	return _nibble_to_hex[_nibble];
}