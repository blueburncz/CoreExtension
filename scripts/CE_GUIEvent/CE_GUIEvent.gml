/// @func CE_GUIEvent()
/// @extends CE_Class
/// @desc Base class for GUI events.
function CE_GUIEvent()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {CE_GUIWidget/undefined}
	/// @readonly
	Target = undefined;

	/// @var {bool}
	Propagate = true;
}