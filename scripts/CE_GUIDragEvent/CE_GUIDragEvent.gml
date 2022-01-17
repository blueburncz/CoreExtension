/// @func CE_GUIDragEvent(_diffX, _diffY)
/// @extends CE_GUIEvent
/// @param {real} _diffX
/// @param {real} _diffY
function CE_GUIDragEvent(_diffX, _diffY)
	: CE_GUIEvent() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {real}
	/// @readonly
	DiffX = _diffX;

	/// @var {real}
	/// @readonly
	DiffY = _diffY;
}