/// @func CE_ArgumentException()
/// @extends CE_Exception
/// @desc An exception thrown if an invalid argument is given to a function.
function CE_ArgumentException(_argumentName)
	: CE_Exception("Invalid argument " + _argumentName + "!") constructor
{
	CE_CLASS_GENERATED_BODY;
}