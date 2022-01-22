/// @func CE_EmptyIterator()
/// @extends CE_Iterator
/// @desc An empty iterator.
function CE_EmptyIterator()
	: CE_Iterator(undefined) constructor
{
	static Reset = function () {};

	static HasNext = function () {
		gml_pragma("forceinline");
		return false;
	};

	static GetNext = function () {
		gml_pragma("forceinline");
		throw new CE_OutOfRangeException();
	};
}