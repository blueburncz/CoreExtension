// TODO: Rewrite for loops to repeats for higher performance.

/// @func CE_ListAddList(_l1, _l2)
/// @desc Adds the list l2 into the list l1.
/// @param {ds_list} _l1 The list to add into.
/// @param {ds_list} _l2 The list to be added.
function CE_ListAddList(_l1, _l2)
{
	gml_pragma("forceinline");
	ds_list_add(_l1, _l2);
	ds_list_mark_as_list(_l1, ds_list_size(_l1) - 1);
}

/// @func CE_ListAddListUnique(_l1, _l2)
/// @desc If the list l2 is not in the list l1, it is added to it.
/// @param {ds_list} _l1 The list to add into.
/// @param {ds_list} _l2 The list to be added.
function CE_ListAddListUnique(_l1, _l2)
{
	gml_pragma("forceinline");
	var _pos = CE_ListAddUnique(_l1, _l2);
	if (_pos == -1)
	{
		ds_list_mark_as_list(_l1, ds_list_size(_l1) - 1);
	}
}

/// @func CE_ListAddMap(_list, _map)
/// @desc Adds the map into the list.
/// @param {ds_list} _list The list to add into.
/// @param {ds_map} _map The map to be added.
function CE_ListAddMap(_list, _map)
{
	gml_pragma("forceinline");
	ds_list_add(_list, _map);
	ds_list_mark_as_map(_list, ds_list_size(_list) - 1);
}

/// @func CE_ListAddMapUnique(_list, _map)
/// @desc If the map is not in the list, it is added to it.
/// @param {ds_list} _list The list to add into.
/// @param {ds_map} _map The map to be added.
function CE_ListAddMapUnique(_list, _map)
{
	gml_pragma("forceinline");
	var _pos = CE_ListAddUnique(_list, _map);
	if (_pos == -1)
	{
		ds_list_mark_as_map(_list, ds_list_size(_list) - 1);
	}
}

/// @func CE_ListAddUnique(_list, _value)
/// @desc If the value is not in the list, it is added to it.
/// @param {ds_list} _list The list.
/// @param {any} _value The value to be added.
/// @return {real} The index on which has the value been found or -1.
function CE_ListAddUnique(_list, _value)
{
	gml_pragma("forceinline");
	var _pos = ds_list_find_index(_list, _value);
	if (_pos == -1)
	{
		ds_list_add(_list, _value);
	}
	return _pos;
}

/// @func CE_ListAppend(_l1, _l2)
/// @desc Adds all values from the list l2 to the end of the list l1.
/// @param {ds_list} _l1 The list to add values to.
/// @param {ds_list} _l2 The list to read values from.
/// @example
/// ```gml
/// var _l1 = ds_list_create();
/// ds_list_add(_l1, 1, 2, 3);
/// var _l2 = ds_list_create();
/// ds_list_add(_l1, 3, 4, 5);
/// // The list _l1 now contains values 1, 2, 3, 3, 4, 5. The _l2 stays
/// // the same.
/// ```
function CE_ListAppend(_l1, _l2)
{
	gml_pragma("forceinline");
	var i = 0;
	repeat (ds_list_size(_l2))
	{
		ds_list_add(_l1, _l2[| i++]);
	}
}

/// @func CE_ListClone(_list)
/// @desc Creates a shallow copy of the list.
/// @param {ds_list} _list The list to clone.
/// @return {ds_list} The created list.
function CE_ListClone(_list)
{
	gml_pragma("forceinline");
	var _clone = ds_list_create();
	ds_list_copy(_clone, _list);
	return _clone;
}

/// @func CE_ListCreateRange(_from, _to)
/// @desc Creates a new list with values in range <from, to>.
/// @param {int} _from The starting value. Must be less or equal to argument to.
/// @param {int} _to The ending value. Must be greater or equal to argument from.
/// @return {ds_list} The created list.
/// @example
/// This will create a list with values `2, 3, 4, 5, 6`.
/// ```gml
/// var _list = CE_ListCreateRange(2, 6);
/// ```
function CE_ListCreateRange(_from, _to)
{
	var _list = ds_list_create();
	repeat (_to - _from + 1)
	{
		ds_list_add(_list, _from++);
	}
	return _list;
}

/// @func CE_ListDistinct(_list)
/// @desc Crates a copy of the list but without duplicate values.
/// @param {ds_list} _list The list to deduplicate.
/// @return {ds_list} The created list.
/// @example
/// Creates a list with values `1, 2, 3, 4, 5`.
/// ```gml
/// var _l1 = ds_list_create();
/// ds_list_add(_l, 1, 2, 2, 3, 5, 4, 5);
/// var _l2 = CE_ListDistinct(_l1);
/// ```
function CE_ListDistinct(_list)
{
	for (var i = 0; i < ds_list_size(_list); ++i)
	{
		var _current = _list[| i];
		for (var j = i + 1; j < ds_list_size(_list); ++j)
		{
			if (_list[| j] == _current)
			{
				ds_list_delete(_list, j);
				--j;
			}
		}
	}
	return _list;
}

/// @func CE_ListFilter(_list, _callback)
/// @desc Creates a new list containing values from the given list for which the
/// callback script returns true.
/// @param {ds_list} _list The list to filter.
/// @param {function} _callback A function that returns `true` to keep the value
/// or `false` to discard it. Takes the original value as the first argument and
/// optionally its index as the second argument.
function CE_ListFilter(_list, _callback)
{
	var _filtered = ds_list_create();
	var i = 0;
	repeat (ds_list_size(_list))
	{
		var _val = _list[| i];
		if (_callback(_val, i))
		{
			ds_list_add(_filtered, _val);
		}
		++i;
	}
	return _filtered;
}

/// @func CE_ListFindIndexLast(_list, _value)
/// @desc Finds the last index at which the list contains the value.
/// @param {ds_list} _list The list to search in.
/// @param {any} _value The value to search for.
/// @return {real} The index at which the value was found or -1 if the list does
/// not contain the value.
function CE_ListFindIndexLast(_list, _value)
{
	for (var i = ds_list_size(_list) - 1; i >= 0; --i)
	{
		if (_list[| i] == _value)
		{
			return i;
		}
	}
	return -1;
}

/// @func CE_ListGet(_list, _index[, _default])
/// @desc Retrieves a value at given index of a list.
/// @param {ds_list} _list The list to Get the value from.
/// @param {real} _index The index.
/// @param {any} [_default] The default value.
/// @return {any} Value at given index or the default value if is specified and
/// the index does not exist.
/// @example
/// ```gml
/// var _list = ds_list_create();
/// ds_list_add(_list, 1, 2);
/// CE_ListGet(_list, 0); // => 1
/// CE_ListGet(_list, 1, 1); // => 2
/// CE_ListGet(_list, 2, 3); // => 3
/// CE_ListGet(_list, 2); // ERROR!
/// ```
function CE_ListGet(_list, _index)
{
	var _size = ds_list_size(_list);
	if (argument_count > 2
		&& (_index < 0 || _index >= _size))
	{
		return argument[2];
	}

	return _list[| _index];
}

/// @func CE_ListInsertList(_l1, _pos, _l2)
/// @desc Inserts the list l2 into the list l1 at the given position.
/// @param {ds_list} _l1 The list to inserted into.
/// @param {real} _pos The index to insert the list at.
/// @param {ds_list} _l2 The list to be inserted.
function CE_ListInsertList(_l1, _pos, _l2)
{
	gml_pragma("forceinline");
	ds_list_insert(_l1, _pos, _l2);
	ds_list_mark_as_list(_l1, _pos);
}

/// @func CE_ListInsertMap(_list, _pos, _map)
/// @desc Inserts the map into the list at the given position.
/// @param {ds_list} _list The list to inserted into.
/// @param {real} _pos The index to insert the list at.
/// @param {ds_map} _map The map to be inserted.
function CE_ListInsertMap(_list, _pos, _map)
{
	gml_pragma("forceinline");
	ds_list_insert(_list, _pos, _map);
	ds_list_mark_as_map(_list, _pos);
}

/// @func CE_ListInsertUnique(_list, _value, _pos)
/// @desc If the value is not in the list, it is inserted to it at given
/// position.
/// @param {ds_list} _list The list to insert to.
/// @param {any} _value The value to be added.
/// @param {real} _pos The index to insert the value at.
/// @return {real} The index on which has been the value found or -1.
function CE_ListInsertUnique(_list, _value, _pos)
{
	gml_pragma("forceinline");
	var _index = ds_list_find_index(_list, _value);
	if (_index == -1)
	{
		ds_list_insert(_list, _pos, _value);
	}
	return _index;
}

/// @func CE_ListInsertIntersect(_l1, _l2)
/// @desc Creates a new list with values being the intersection of l1 and l2.
/// @param {ds_list} _l1 The first list.
/// @param {ds_list} _l2 The second list.
/// @return {ds_list} The crated list.
/// @example
/// This will create a list with value `3`.
/// ```gml
/// var _l1 = ds_list_create();
/// ds_list_add(_l1, 1, 2, 3);
/// var _l2 = ds_list_create();
/// ds_list_add(_l1, 3, 4, 5);
/// var _l3 = CE_ListInsertIntersect(_l1, _l2);
/// ```
function CE_ListInsertIntersect(_l1, _l2)
{
	var _list = CE_ListDistinct(_l1);
	for (var i = ds_list_size(_list) - 1; i >= 0; --i)
	{
		if (ds_list_find_index(_l2, _list[| i]) == -1)
		{
			ds_list_delete(_list, i);
		}
	}
	return _list;
}

/// @func CE_ListMap(_list, _callback)
/// @desc Creates a new list containing the results of calling the script on
/// every value in the given list.
/// @param {ds_list} _list The list to map.
/// @param {function} _callback A function that produces a value of the new list,
/// taking the original value as the first argument and optionally its index
/// as the second argument.
function CE_ListMap(_list, _callback)
{
	var _mapped = ds_list_create();
	var _size = ds_list_size(_list);
	for (var i = 0; i < _size; ++i)
	{
		ds_list_add(_mapped, script_execute(_callback, _list[| i], i));
	}
	return _mapped;
}

/// @func CE_ListMerge(_l1, _l2)
/// @desc Merges the lists into a new one, which will contain all values from
/// both of them (including duplicates).
/// @param {ds_list} _l1 The first list.
/// @param {ds_list} _l2 The second list.
/// @return {ds_list} The created list.
/// @example
/// This will create a list with values `1, 2, 3, 3, 4, 5`.
/// ```gml
/// var _l1 = ds_list_create();
/// ds_list_add(_l1, 1, 2, 3);
/// var _l2 = ds_list_create();
/// ds_list_add(_l1, 3, 4, 5);
/// var _l3 = CE_ListMerge(_l1, _l2);
/// ```
function CE_ListMerge(_l1, _l2)
{
	var _merged = ds_list_create();
	ds_list_copy(_merged, _l1);
	CE_ListAppend(_merged, _l2);
	return _merged;
}

/// @func CE_ListReduce(_list, _callback[, _initialValue])
/// @desc Reduces the list from left to right, applying the callback script on
/// each value, resulting into a single value.
/// @param {ds_list} _list The list to reduce.
/// @param {function} _callback The reducer function. It takes the accumulator (which
/// is the `_initialValue` at start) as the first argument, the current value as
/// the second argument and optionally the current index as the third argument.
/// @param {any} [_initialValue] The initial value. If not specified, the first
/// value in the list is taken.
/// @return {any} The result of the reduction.
/// @example
/// ```gml
/// var _add = function (_a, _b) { return (_a + _b); };
/// var _l = ds_list_create();
/// ds_list_add(_l, 1, 2, 3, 4);
/// var _r1 = CE_ListReduce(_l, _add); // Results to 10
/// var _r2 = CE_ListReduce(_l, _add, 5); // Results to 15
/// ```
/// @see CE_ListReduceRight
function CE_ListReduce(_list, _callback)
{
	var i = 0;
	var _accumulator = (argument_count > 2) ? argument[2] : _list[| i++];
	repeat (ds_list_size(_list) - i)
	{
		_accumulator = script_execute(_callback, _accumulator, _list[| i], i);
		++i;
	}
	return _accumulator;
}

/// @func CE_ListReduceRight(_list, _callback[, _initialValue])
/// @desc Reduces the list from right to left, applying the callback script on
/// each value, resulting into a single value.
/// @param {ds_list} _list The list to reduce.
/// @param {function} _callback The reducer function. It takes the accumulator (which
/// is the `_initialValue` at start) as the first argument, the current value as
/// the second argument and optionally the current index as the third argument.
/// @param {any} [_initialValue] The initial value. If not specified, the last
/// value in the list is taken.
/// @return {any} The result of the reduction.
/// @example
/// ```gml
/// var _subtract = function (_a, _b) { return (_a - _b); };
/// var _l = ds_list_create();
/// ds_list_add(_l, 1, 2, 3, 4);
/// var _r1 = CE_ListReduce(_l, _subtract); // Results to -8
/// var _r2 = CE_ListReduceRight(_l, _subtract); // Results to -2
/// ```
/// @see CE_ListReduce
function CE_ListReduceRight(_list, _callback)
{
	var i = ds_list_size(_list) - 1;
	var _accumulator = (argument_count > 2) ? argument[2] : _list[| i--];
	repeat (i + 1)
	{
		_accumulator = _callback(_accumulator, _list[| i], i);
		--i;
	}
	return _accumulator;
}

/// @func CE_ListRemove(_list, _value)
/// @desc Removes all occurrences of the value from the list.
/// @param {ds_list} _list The list to remove the value from.
/// @param {any} _value The value to remove.
function CE_ListRemove(_list, _value)
{
	var i = ds_list_size(_list) - 1;
	repeat (i + 1)
	{
		if (_list[| i] == _value)
		{
			ds_list_delete(_list, i);
		}
		--i;
	}
}

/// @func CE_ListRemoveFirst(_list, _value)
/// @desc Removes the first occurrence of the value from the list.
/// @param {ds_list} _list The list to remove the value from.
/// @param {any} _value The value to remove.
/// @return {bool} Returns `true` if the value was in the list.
function CE_ListRemoveFirst(_list, _value)
{
	var _index = ds_list_find_index(_list, _value);
	if (_index != -1)
	{
		ds_list_delete(_list, _index);
		return true;
	}
	return false;
}

/// @func CE_ListRemoveLast(_list, _value)
/// @desc Removes the last occurrence of the value from the list.
/// @param {ds_list} _list The list to remove the value from.
/// @param {any} _value The value to remove.
/// @param {bool} `true` if the value was in the list.
function CE_ListRemoveLast(_list, _value)
{
	var i = ds_list_size(_list) - 1;
	repeat (i + 1)
	{
		if (_list[| i] == _value)
		{
			ds_list_delete(_list, i);
			return true;
		}
		--i;
	}
	return false;
}

/// @func CE_ListReverse(_list)
/// @desc Creates a new list with values from the given list, but in a reverse
/// order.
/// @param {ds_list} _list The list to reverse.
/// @return {ds_list} The created list.
function CE_ListReverse(_list)
{
	var _reversed = ds_list_create();
	var i = ds_list_size(_list) - 1;
	repeat (i + 1)
	{
		ds_list_add(_reversed, _list[| i--]);
	}
	return _reversed;
}

/// @func CE_ListSlice(_list[, _start[, _end]])
/// @desc Creates a copy of a list, taking values from specified range of indices.
/// @param {ds_list} _list The list to copy.
/// @param {real} _start The starting index.
/// @param {real} _end The ending index (not included).
/// @return {ds_list} The created list.
function CE_ListSlice(_list)
{
	var _start = (argument_count > 1) ? argument[1] : 0;
	var _end = (argument_count > 2) ? argument[2] : ds_list_size(_list);
	var _slice = ds_list_create();
	var i = _start;
	repeat (_end - _start)
	{
		ds_list_add(_slice, _list[| i++]);
	}
	return _slice;
}

/// @func CE_ListSwap(_list, _i, _j)
/// @desc Swaps values at given indices in the list.
/// @param {ds_list} _list The list to swap values within.
/// @param {real} _i The first index.
/// @param {real} _j The second index.
/// @example
/// ```gml
/// var _list = ds_list_create();
/// ds_list_add(_list, 1, 2, 3);
/// CE_ListSwap(_list, 0, 2); // Swaps 1 and 3, making the list `3, 2, 1`.
/// ```
function CE_ListSwap(_list, _i, _j)
{
	gml_pragma("forceinline");
	var _temp = _list[| _i];
	_list[| _i] = _list[| _j];
	_list[| _j] = _temp;
}

/// @func CE_ListUnion(_l1, _l2)
/// @desc Creates a new list with values being the union of l1 and l2.
/// @param {ds_list} _l1 The first list.
/// @param {ds_list} _l2 The second list.
/// @return {ds_list} The the created list.
/// @example
/// This will create a list with values `1, 2, 3, 4, 5`.
/// ```gml
/// var _l1 = ds_list_create();
/// ds_list_add(_l1, 1, 2, 3);
/// var _l2 = ds_list_create();
/// ds_list_add(_l1, 3, 4, 5);
/// var _l3 = CE_ListUnion(_l1, _l2);
/// ```
function CE_ListUnion(_l1, _l2)
{
	var _union = CE_ListMerge(_l1, _l2);
	ds_list_sort(_union, true);
	var i = ds_list_size(_union) - 1;
	while (i > 0)
	{
		if (_union[| i - 1] == _union[| i])
		{
			ds_list_delete(_union, i);
		}
		--i;
	}
	return _union;
}