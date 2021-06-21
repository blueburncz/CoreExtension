/// @func CE_Error([_message])
/// @param {string} [_message] The error message. Defaults to an empty stirng.
function CE_Error() constructor
{
	/// @var {string} The error message.
	/// @readonly
	Message = (argument_count > 0) ? argument[0] : "";
}

/// @func CE_NotImplementedError()
/// @extends CE_Error
/// @desc An error thrown when a method is not implemented.
function CE_NotImplementedError()
	: CE_Error(("Method not implemented!")) constructor
{
}