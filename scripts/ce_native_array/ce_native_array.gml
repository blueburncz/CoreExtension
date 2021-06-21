/// @func CE_NativeArray(_type, _size)
/// @desc Implements an array using a buffer. This can be used to share
/// the array with a dynamic library through a pointer to the buffer.
/// @param {uint} _type The type of all values in the array. Use one of
/// the `buffer_` types. `buffer_string` and `buffer_text` are currently
/// not supported!
/// @param {uint} _size The size of the array.
/// @see ce_native_array_from_array
function CE_NativeArray(_type, _size) constructor
{
	/// @var {uint} The type of values within the array. See `buffer_`
	/// constants.
	/// @readonly
	Type = _type;

	/// @var {uint} The size of the type in bytes.
	/// @readonly
	TypeSize = buffer_sizeof(Type);

	/// @var {uint} The size of the array.
	/// @readonly
	Size = _size;

	/// @var {buffer} The underlying buffer.
	/// @private
	// TODO: Fix native array buffer alignment?
	Buffer = buffer_create(TypeSize * Size, buffer_fixed, 1);

	/// @func GetPtr()
	/// @desc Retrieves a pointer to the underyling buffer.
	/// @return {ptr} The pointer to the underlying buffer.
	/// @example
	/// ```gml
	/// function native_array_sort(_nativeArray)
	/// {
	///     gml_pragma("forceinline");
	///     static _fn = external_define(
	///         "MyExtension.dll",
	///         "native_array_sort",
	///         dll_cdecl,
	///         ty_real,
	///         3,
	///         ty_string, // Pointer to the buffer
	///         ty_real,   // Size of the array
	///         ty_real);  // Size of array entry type in bytes
	///     return external_call(_fn, _nativeArray.GetPtr(), _nativeArray.Size, _nativeArray.TypeSize);
	/// }
	/// ```
	static GetPtr = function () {
		gml_pragma("forceinline");
		return buffer_get_address(Buffer);
	};

	/// @func GetByteSize()
	/// @desc Retrieves the total size of the array in bytes.
	/// @return {uint} The total size of the array in bytes.
	static GetByteSize = function () {
		gml_pragma("forceinline");
		return buffer_get_size(Buffer);
	};

	/// @func Get(_index)
	/// @desc Retrieves a value at given index.
	/// @param {uint} _index A position within the native array to read
	/// the value from.
	/// @return {real} The value at given index.
	static Get = function (_index) {
		gml_pragma("forceinline");
		buffer_seek(Buffer, buffer_seek_start, TypeSize * _index);
		return buffer_read(Buffer, Type);
	};

	/// @func Set(_index, _value)
	/// @desc Sets a value at given index.
	/// @param {uint} _index A position within the native to set the value
	/// at.
	/// @param {real} _value The value.
	/// @return {CE_NativeArray} Returns `self`.
	static Set = function (_index, _value) {
		gml_pragma("forceinline");
		buffer_seek(Buffer, buffer_seek_start, TypeSize * _index);
		buffer_write(Buffer, Type, _value);
		return self;
	};

	/// @func FromArray(_array)
	/// @desc Copies values from a normal array into the native array.
	/// @param {real[]} _array The array to copy the values from.
	/// @return {CE_NativeArray} Returns `self`.
	static FromArray = function (_array) {
		gml_pragma("forceinline");
		var i = 0;
		buffer_seek(Buffer, buffer_seek_start, 0);
		repeat (min(array_length(_array), Size))
		{
			buffer_write(Buffer, Type, _array[i++]);
		}
		return self;
	};

	/// @func ToArray([_array])
	/// @desc Copies all values from the native array into a normal array.
	/// @param {array} [_array] The target array to copy the values to. If
	/// not specified, then a new one is created.
	/// @return {real[]} The target array.
	static ToArray = function () {
		gml_pragma("forceinline");
		var _array = (argument_count > 0) ? argument[0] : array_create(Size, 0);
		var i = 0;
		buffer_seek(Buffer, buffer_seek_start, 0);
		repeat (Size)
		{
			_array[@ i++] = buffer_read(Buffer, Type);
		}
		return _array;
	};

	/// @func ToString()
	/// @desc Pretty-prints the native array into a string.
	/// @return {string} The created string.
	static ToString = function () {
		gml_pragma("forceinline");
		var _str = "[ ";
		buffer_seek(Buffer, buffer_seek_start, 0);
		repeat (Size - 1)
		{
			_str += string(buffer_read(Buffer, Type)) + ", ";
		}
		return (_str + string(buffer_read(Buffer, Type)) + " ]");
	};

	/// @func Destroy()
	/// @desc Frees memory used by the native array.
	static Destroy = function () {
		gml_pragma("forceinline");
		buffer_delete(Buffer);
	};
}

/// @func ce_native_array_from_array(_array, _type)
/// @desc Creates a new {@link CE_NativeArray} and fills it with values from
/// the given array.
/// @param {real[]} _array The array to create a native array from.
/// @param {uint} _type The type of all values in the array. Use one of
/// the `buffer_` types. `buffer_string` and `buffer_text` are currently
/// not supported!
/// @return {CE_NativeArray} The created native array.
/// @see CE_NativeArray
function ce_native_array_from_array(_array, _type)
{
	gml_pragma("forceinline");
	return new CE_NativeArray(_type, array_length(_array)).FromArray(_array);
}