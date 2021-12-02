/// @func CE_GUIKeyDownEvent(_key)
/// @extends CE_GUIEvent
/// @param {int} _key
function CE_GUIKeyDownEvent(_key)
	: CE_GUIEvent() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {int}
	/// @readonly
	Key = _key;
}