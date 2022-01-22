/// @func CE_GenerateUUID([_bytes])
/// @desc Generates a version 4 UUID.
/// @param {array} [_bytes] An array that will be used for storing random bytes.
/// Its size must be 16! If the array is not provided, a new one is created.
/// Providing the array can Save some extra ms when sequentially generating
/// large numbers of UUIDs.
/// @return {string} The generated UUID.
/// @note Depends on the `_to_hex` functions.
/// @source https://www.cryptosys.net/pki/uuid-rfc4122.html
function CE_GenerateUUID()
{
	var _bytes = (argument_count > 0) ? argument[0] : array_create(16, 0);

	var _seed = random_get_seed();
	randomize();
	for (var i = 0; i < 16; ++i)
	{
		_bytes[@ i] = irandom(255);
	}
	random_set_seed(_seed);

	_bytes[@ 6] = (0x40 | (_bytes[6] & 0xF));
	_bytes[@ 8] = (0x80 | (_bytes[8] & 0x3F));

	var _str = CE_ByteArrayToHex(_bytes);

	return string_copy(_str, 1, 8) + "-"
		+ string_copy(_str, 9, 4) + "-"
		+ string_copy(_str, 13, 4) + "-"
		+ string_copy(_str, 17, 4) + "-"
		+ string_copy(_str, 21, 12);
}