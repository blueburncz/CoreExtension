/// @func CE_GUIEvent(_type)
/// @param _type
function CE_GUIEvent(_type)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {CE_EGuiEvent}
	/// @readonly
	Type = _type;

	/// @var {CE_GUIWidget/undefined}
	/// @readonly
	Target = undefined;

	/// @var {bool}
	Propagate = true;
}