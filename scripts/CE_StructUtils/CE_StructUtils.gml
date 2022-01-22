/// @func CE_StructGet(_struct, _name[, _default])
/// @desc Retrieves structure's property value.
/// @param {struct} _struct The structure.
/// @param {string} _name The property name.
/// @param {any} [_default] The value returned when the struct doesn't have
/// such property.
/// @return {any} The property value.
function CE_StructGet(_struct, _name, _default=undefined)
{
	gml_pragma("forceinline");
	if (!variable_struct_exists(_struct, _name))
	{
		return _default;
	}
	return variable_struct_get(_struct, _name);
}

/// @func CE_StructSet(_struct, _name, _value)
/// @desc Sets structure's property value.
/// @param {struct} _struct The structure.
/// @param {string} _name The property name.
/// @param {any} _value The value.
/// @note This is equivalent to using `variable_struct_set`.
function CE_StructSet(_struct, _name, _value)
{
	gml_pragma("forceinline");
	variable_struct_set(_struct, _name, _value);
}

/// @func CE_StructExtend(_target, ..._source)
/// @desc Extends target structure with properties from source structure.
/// @param {struct} _target The structure to add the properties to.
/// @param {struct} _source The structure containing properties to add.
/// @return {struct} Returns the target structure.
function CE_StructExtend(_target)
{
	gml_pragma("forceinline");
	var s = 1;
	repeat (argument_count - 1)
	{
		var _source = argument[s++];
		var _names = variable_struct_get_names(_source);
		var n = 0;
		repeat (array_length(_names))
		{
			var _name = _names[n++];
			_target[$ _name] = _source[$ _name];
		}
	}
	return _target;
}