/// @func CE_GUIChangeEvent(_valueOld)
/// @extends CE_GUIEvent
/// @param {any} _valueOld
function CE_GUIChangeEvent(_valueOld)
	: CE_GUIEvent() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {any}
	/// @readonly
	ValueOld = _valueOld;
}