/// @func CE_Exception([_message])
/// @extends CE_Class
/// @desc The base struct for exceptions thrown by the CE library.
/// @param {string} [_message] An exception message. Defaults to an empty string.
function CE_Exception(_message="")
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {string} The exception message.
	/// @readonly
	Message = _message;
}