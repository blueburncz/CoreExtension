/// @func CE_Iterator(_data)
/// @extends CE_Class
/// @desc Base class for iterators.
/// @param {any} _data An iterable data structure.
function CE_Iterator(_data)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var The data structure to iterate through.
	/// @private
	Data = _data;

	/// @func Reset()
	/// @desc Resets the iterator to the beginning.
	/// @throws {CE_NotImplementedException} If the method is not implemented.
	static Reset = function () {
		throw new CE_NotImplementedException();
	};

	/// @func HasNext()
	/// @desc Checks whether the iterator has a next entry.
	/// @return {bool} Returns true if the iterator has a next entry.
	/// @throws {CE_NotImplementedException} If the method is not implemented.
	/// @see CE_Iterator.GetNext
	static HasNext = function () {
		throw new CE_NotImplementedException();
	};

	/// @func GetNext()
	/// @desc Retrieves the next entry in the iterator.
	/// @return {any} Returns the next entry.
	/// @throws {CE_OutOfRangeException} If there is no next entry.
	/// @throws {CE_NotImplementedException} If the method is not implemented.
	/// @see CE_Iterator.HasNext
	static GetNext = function () {
		throw new CE_NotImplementedException();
	};
}