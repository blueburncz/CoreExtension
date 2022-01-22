/// @func CE_ListIterator(_list)
/// @extends CE_Iterator
/// @desc Implements an iterator over a `ds_list`.
/// @param {ds_list<any>} _list The list to iterate through.
function CE_ListIterator(_list)
	: CE_Iterator(_list) constructor
{
	Index = 0;

	static Reset = function () {
		gml_pragma("forceinline");
		Index = 0;
	};

	static HasNext = function () {
		gml_pragma("forceinline");
		return (Index < ds_list_size(Data));
	};

	/// @func GetNext()
	/// @desc Retrieves the next value in the list.
	/// @return {any} The next value in the list.
	/// @throws {CE_OutOfRangeException} When there is no next value in the list.
	static GetNext = function () {
		gml_pragma("forceinline");
		if (Index >= ds_list_size(Data))
		{
			throw new CE_OutOfRangeException();
		}
		return Data[| Index++];
	};
}