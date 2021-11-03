/// @func CE_Exception([_message])
/// @desc The base struct for exceptions thrown by the CE library.
/// @param {string} [_message] An exception message. Defaults to an empty string.
function CE_Exception(_message="") constructor
{
	/// @var {string} The exception message.
	/// @readonly
	Message = _message;
}