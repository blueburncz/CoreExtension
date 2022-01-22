/// @func CE_MapIteratorEntry(_key, _value)
/// @desc An item returned by an {@link CE_MapIterator}.
/// @param {string} _key The entry key.
/// @param {any} _value The entry value.
/// @see CE_MapIterator
function CE_MapIteratorEntry(_key, _value) constructor
{
	/// @var {string} The entry key.
	/// @readonly
	Key = _key;

	/// @var {any} The entry value.
	/// @readonly
	Value = _value;
}