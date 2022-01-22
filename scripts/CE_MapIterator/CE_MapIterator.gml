/// @func CE_MapIterator(_map)
/// @extends CE_Iterator
/// @desc Implements an iterator over a `ds_map`.
/// @param {ds_map<string, any>} _map The map to iterate through.
function CE_MapIterator(_map)
	: CE_Iterator(_map) constructor
{
	Index = ds_map_find_first(Data);

	static Reset = function () {
		gml_pragma("forceinline");
		Index = ds_map_find_first(Data);
	};

	static HasNext = function () {
		gml_pragma("forceinline");
		return (Index != undefined);
	};

	/// @func GetNext()
	/// @desc Retrieves the next entry in the map.
	/// @return {CE_MapIteratorEntry} The next entry in the map.
	/// @throws {CE_OutOfRangeException} When there is no next entry in the map.
	/// @see CE_MapIteratorEntry
	static GetNext = function () {
		gml_pragma("forceinline");
		if (Index == undefined)
		{
			throw new CE_OutOfRangeException();
		}
		var _entry = new CE_MapIteratorEntry(Index, Data[? Index]);
		Index = ds_map_find_next(Data, Index);
		return _entry;
	};
}