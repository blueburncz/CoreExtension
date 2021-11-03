/// @func CE_ComponentGetIndex()
/// @param {typeof CE_Component/CE_Component}
/// @return {string}
/// @private
function CE_ComponentGetIndex(_component)
{
	gml_pragma("forceinline");
	return is_struct(_component)
		? _component.ComponentIndex
		: script_get_name(_component);
}

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

/// @macro Must be the first line when difining a custom component.
/// @example
/// ```gml
/// function CPositionComponent(_x, _y)
///     : CE_Component() constructor
/// {
///     CE_COMPONENT_GENERATE_BODY;
///     X = _x;
///     Y = _y;
/// }
/// ```
#macro CE_COMPONENT_GENERATED_BODY \
	static ComponentIndex = CE_GetCallingFunctionName()

/// @func CE_Component()
/// @extends CE_Class
/// @desc Base class for entity components.
/// @see CE_Entity
function CE_Component()
	: CE_Class() constructor
{
	CE_COMPONENT_GENERATED_BODY;

	/// @var The owner of the component. Equals to `undefined` if the component
	/// has not been added to an entity yet.
	/// @readonly
	Owner = undefined;
}