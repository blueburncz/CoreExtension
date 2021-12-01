/// @func CE_GUIEvent(_type)
/// @param _type
function CE_GUIEvent(_type)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	Type = _type;

	Target = noone;
}