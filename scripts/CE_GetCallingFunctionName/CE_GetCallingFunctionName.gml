/// @func CE_GetCallingFunctionName()
/// @desc Retrieves name of the calling function.
/// @return {string} The name of the calling function.
function CE_GetCallingFunctionName()
{
	gml_pragma("forceinline");
	var _name = debug_get_callstack(2)[1];
	_name = string_replace(_name, "gml_Script_", "");
	return string_copy(_name, 1, string_pos(":", _name) - 1);
}