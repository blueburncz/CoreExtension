/// @func CE_Class()
/// @desc Base for CE structs that require more OOP functionality.
function CE_Class() constructor
{
	/// @var {func[]} An array of implemented interfaces.
	/// @private
	Interfaces = [];

	/// @var {func[]} An array of functions executed when the destroy method
	/// is called.
	/// @private
	OnDestroy = [];

	/// @func Implement(_interface)
	/// @desc Implements an interface into the struct.
	/// @return {CE_Class} Returns `self`.
	/// @throws {CE_Exception} If the struct already implements the interface.
	static Implement = function (_interface) {
		gml_pragma("forceinline");
		if (Implements(_interface))
		{
			throw new CE_Exception("Interface already implemented!");
			return self;
		}
		array_push(Interfaces, _interface);
		method(self, _interface)();
		return self;
	};

	/// @func Implements(_interface)
	/// @desc Checks whether the struct implements an interface.
	/// @param {func} _interface The interface to check.
	/// @return {bool} Returns `true` if the struct implements the interface.
	static Implements = function (_interface) {
		gml_pragma("forceinline");
		var i = 0;
		repeat (array_length(Interfaces))
		{
			if (Interfaces[i++] == _interface)
			{
				return true;
			}
		}
		return false;
	};

	/// @func Destroy()
	/// @desc Frees resources used by the struct from memory.
	static Destroy = function () {
		var i = 0;
		repeat (array_length(OnDestroy))
		{
			method(self, OnDestroy[i++])();
		}
	};
}