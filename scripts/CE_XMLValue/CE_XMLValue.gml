/// @func CE_XMLValueFromString(_string)
/// @desc Parses value from the string.
/// @param {string} _string The string to parse.
/// @return {real/string} Real value or a string, where XML character entities
/// are replaced with their original form.
function CE_XMLValueFromString(_string)
{
	// Clear whitespace, replace character entities
	while (string_byte_at(_string, 1) == 32)
	{
		_string = string_delete(_string, 1, 1);
	}

	_string = string_replace_all(_string, "&lt;", "<");
	_string = string_replace_all(_string, "&gt;", ">");
	_string = string_replace_all(_string, "&quot;", "\"");
	_string = string_replace_all(_string, "&apos;", "'");
	_string = string_replace_all(_string, "&amp;", "&");

	// Parse real
	var _real = CE_RealParse(_string);

	if (is_nan(_real))
	{
		return _string;
	}

	return _real;
}

/// @func CE_XMLValueToString(_value)
/// @desc Turns a value into an XML-safe string.
/// @param {any} _value The value to be turned into a string.
/// @return {string} The resulting string.
function CE_XMLValueToString(_value)
{
	if (is_real(_value))
	{
		var _dec = 16; // Maximum decimal places
		var _string = string_format(_value, -1, _dec);
		var _stringLength = string_length(_string);

		do
		{
			_string = string_format(_value, -1, --_dec);
			if (string_byte_at(_string, --_stringLength) != 48)
			{
				break;
			}
		}
		until (_dec == 0);

		return _string;
	}

	if (is_string(_value))
	{
		_value = string_replace_all(_value, "&", "&amp;");
		_value = string_replace_all(_value, "<", "&lt;");
		_value = string_replace_all(_value, ">", "&gt;");
		_value = string_replace_all(_value, "\"", "&quot;");
		_value = string_replace_all(_value, "'", "&apos;");
	}

	return string(_value);
}