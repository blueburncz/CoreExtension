/// @func CE_OutOfRangeException()
/// @extends CE_Exception
/// @desc An exception thrown when you try to read a value from a data structure
/// at an index which is out of its range.
function CE_OutOfRangeException()
	: CE_Exception("Index out of range!") constructor
{
	CE_CLASS_GENERATED_BODY;
}