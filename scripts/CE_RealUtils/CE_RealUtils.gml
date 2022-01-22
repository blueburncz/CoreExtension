/// @func CE_RealParse(string)
/// @desc Parses a real number from a string.
/// @param {string} string The string to Parse the number from.
/// @return {real/string} The parsed number or `NaN` if the string does not
/// represent a number.
function CE_RealParse(_string)
{
	var _sign = 1;
	var _number = "0";
	var _index = 1;
	var _state = 0;

	repeat (string_length(_string) + 1)
	{
		var _char = string_char_at(_string, _index++);

		switch (_state)
		{
		case 0:
			if (_char == "-")
			{
				_sign *= -1;
			}
			else if (_char == "+")
			{
				_sign *= +1;
			}
			else if (CE_CharIsDigit(_char)
				|| _char == ".")
			{
				_state = 1;
				--_index;
			}
			else
			{
				return NaN;
			}
			break;

		case 1:
			if (CE_CharIsDigit(_char)
				|| _char == ".")
			{
				_number += _char;
			}
			else
			{
				return NaN;
			}
			break;

		case 2:
			if (CE_CharIsDigit(_char))
			{
				_number += _char;
			}
			else
			{
				return NaN;
			}
			break;
		}
	}

	return _sign * real(_number);
}

/// @func CE_RealCompare(r1, r2)
/// @desc Compares two numbers.
/// @param {real} _r1 The first number.
/// @param {real} _r2 The second number.
/// @return {real} Returns `cmpfunc_equal` if the numbers are equal or
/// `cmpfunc_less` / `cmpfunc_greater` if the first number is
/// less / greater than the second number.
/// @example
/// Sorting an array of numbers using a bubble sort algorithm and this function
/// for number comparison.
/// ```gml
/// var _numbers = [3, 1, 2];
/// var _size = array_length(_numbers);
/// for (var i = 0; i < _size - 1; ++i)
/// {
///     for (var j = 0; j < _size - i - 1; ++j)
///     {
///         if (CE_RealCompare(_numbers[j], _numbers[j + 1]) == cmpfunc_greater)
///         {
///             CE_ArraySwap(_numbers, j, j + 1);
///         }
///     }
/// }
/// // The array is now equal to [1, 2, 3].
/// ```
function CE_RealCompare(_r1, _r2)
{
	gml_pragma("forceinline");
	return ((_r1 < _r2) ? cmpfunc_less
		: ((_r1 > _r2) ? cmpfunc_greater
		: cmpfunc_equal));
}

/// @func CE_RealIsEven(_real)
/// @param {real} _real The number to check.
/// @return {bool} Returns `true` if the number is even.
function CE_RealIsEven(_real)
{
	gml_pragma("forceinline");
	return (_real & $1 == 0);
}

/// @func CE_RealIsOdd(_real)
/// @param {real} _real The number to check.
/// @return {bool} Returns `true` if the number is odd.
function CE_RealIsOdd(_real)
{
	gml_pragma("forceinline");
	return (_real & $1 == 1);
}

/// @func CE_RealToString(_real[, _decimalPlaces])
/// @desc Converts a real value to a string without generating trailing zeros
/// after a decimal point.
/// @param {real} _real The real value to convert to a string.
/// @param {real} [_decimalPlaces] Maximum decimal places. Defaults to 16.
/// @return {string} The resulting string.
/// @example
/// ```gml
/// CE_RealToString(16); // => 16
/// CE_RealToString(16.870); // => 16.87
/// ```
function CE_RealToString(_real, _decimalPlaces=16)
{
	var _string = string_format(_real, -1, _decimalPlaces);
	var _stringLength = string_length(_string);

	while (_decimalPlaces >= 0
		&& string_byte_at(_string, _stringLength) == 48)
	{
		_string = string_format(_real, -1, --_decimalPlaces);
		--_stringLength;
	}

	return _string;
}