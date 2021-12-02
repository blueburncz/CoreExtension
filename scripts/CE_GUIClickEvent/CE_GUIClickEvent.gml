/// @func CE_GUIClickEvent(_button)
/// @extends CE_GUIEvent
/// @param {int} _button
function CE_GUIClickEvent(_button)
	: CE_GUIEvent() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {int}
	/// @readonly
	Button = _button;
}