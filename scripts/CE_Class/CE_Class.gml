/// @macro Must be the first line when defining a custom class!
/// @example
/// ```gml
/// function CRectangle(_x, _y, _width, _height)
///     : CE_Class() constructor
/// {
///     CE_CLASS_GENERATED_BODY;
///     X = _x;
///     Y = _y;
///     Width = _width;
///     Height = _height;
/// }
/// ```
#macro CE_CLASS_GENERATED_BODY \
	static __ClassName = CE_GetCallingFunctionName(); \ // TODO: Could be instanceof?
	array_push(__Inheritance, __ClassName)

/// @func CE_Class()
/// @desc Base for CE structs that require more OOP functionality.
function CE_Class() constructor
{
	/// @var {string[]} An array of names of inherited classes.
	/// @private
	__Inheritance = [];

	CE_CLASS_GENERATED_BODY;

	/// @var {string[]} An array of names of implemented interfaces.
	/// @private
	__Interfaces = [];

	/// @var {func[]} An array of functions executed when the destroy method
	/// is called.
	/// @private
	__DestroyActions = [];

	/// @func IsInstance(_class)
	/// @desc Checks if the struct inherits from given class.
	/// @param {typeof CE_Class} _class The class type.
	/// @return {bool} Returns `true` if the struct inherits from the class.
	static IsInstance = function (_class) {
		gml_pragma("forceinline");
		return ce_array_includes(__Inheritance, CE_ClassGetName(_class));
	};

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
		array_push(__Interfaces, _interface);
		method(self, _interface)();
		return self;
	};

	/// @func Implements(_interface)
	/// @desc Checks whether the struct implements an interface.
	/// @param {typeof CE_Class} _interface The interface to check.
	/// @return {bool} Returns `true` if the struct implements the interface.
	static Implements = function (_interface) {
		gml_pragma("forceinline");
		return ce_array_includes(__Interfaces, CE_ClassGetName(_interface));
	};

	/// @func Destroy()
	/// @desc Frees resources used by the struct from memory.
	static Destroy = function () {
		gml_pragma("forceinline");
		var _destroyActions = __DestroyActions;
		var i = 0;
		repeat (array_length(_destroyActions))
		{
			method(self, _destroyActions[i++])();
		}
	};
}

/// @func CE_IsClass(_value)
/// @desc Checks if a value is an instance of `CE_Class`.
/// @param {any} _value The value to check.
/// @return {bool} Returns `true` if the value is an instance of `CE_Class`.
/// @see CE_Class
function CE_IsClass(_value)
{
	gml_pragma("forceinline");
	return (is_struct(_value)
		&& variable_struct_exists(_value, "__ClassName"));
}

/// @func CE_ClassGetName(_class)
/// @desc Retrieves class name from class instance or class type.
/// @param {typeof CE_Class/CE_Class} _class The class instance or the class type.
/// @return {string} The name of the class.
function CE_ClassGetName(_class)
{
	gml_pragma("forceinline");
	return is_struct(_class)
		? _class.__ClassName
		: script_get_name(_class);
}