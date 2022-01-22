/// @func CE_ObjectGetBase(_object)
/// @param {real} _object The object index.
/// @return {real} The index of the base object in the object's ancestors
/// hierarchy.
/// @example
/// If object `C` has parent `B` and object `B` has parent `A`, then
/// `CE_ObjectGetBase(C) would return `A`.
function CE_ObjectGetBase(_object)
{
	while (true)
	{
		var _parent = object_get_parent(_object);
		if (_parent < 0)
		{
			return _object;
		}
		_object = _parent;
	}
}

/// @func CE_ObjectIs(_a, _b)
/// @param {real} _a The index of object A.
/// @param {real} _b The index of object B.
/// @return {bool} Returns `true` if object A is or inherits from object B.
function CE_ObjectIs(_a, _b)
{
	gml_pragma("forceinline");
	return (_a == _b || object_is_ancestor(_a, _b));
}