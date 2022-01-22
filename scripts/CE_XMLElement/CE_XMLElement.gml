/// @func CE_XMLElement([_name[, _valueOrChildElements]])
/// @extends CE_Class
/// @desc An XML element.
/// @param {string} [_name] The name of the element. Defaults to an empty string.
/// @param {string/real/undefined/CE_XMLElement[]} [_valueOrChildElements] Either
/// the element's value or an array of its child elements. Defaults to undefined.
function CE_XMLElement(_name="", _valueOrChildElements=undefined)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	/// @var {string} The name of the element.
	Name = _name;

	/// @var {string/real/undefined} The element value. If it's undefined, then
	/// the element doesn't have a value.
	Value = _valueOrChildElements;

	/// @var {CE_XMLElement/undefined} The parent element. If it's undefined, then
	/// this is the root element.
	/// @readonly
	Parent = undefined;

	/// @var {ds_list<CE_XMLElement>/undefined} A list of the element's child
	/// elements or undefined if it doesn't have any.
	/// @private
	Children = undefined;

	/// @var {ds_map<string, string/real>/undefined} A map of the element's
	/// attributes or undefined if it doesn't have any.
	/// @private
	Attributes = undefined;

	if (is_array(Value))
	{
		var _length = array_length(Value);
		for (var i = 0; i < _length; ++i)
		{
			AddChild(Value[i]);
		}
		Value = undefined;
	}

	/// @func Remove()
	/// @desc Removes itself from its parent.
	/// @return {CE_XMLElement} Returns `self`.
	static Remove = function () {
		var _index = ds_list_find_index(Parent.Children, self);
		if (_index >= 0)
		{
			ds_list_delete(Parent.Children, _index);
		}
		Parent = undefined;
		return self;
	};

	/// @func AddChild(_child)
	/// @desc Adds a child element.
	/// @param {CE_XMLElement} _child The child element.
	/// @return {CE_XMLElement} Returns `self`.
	static AddChild = function (_child) {
		gml_pragma("forceinline");
		if (Children == undefined)
		{
			Children = ds_list_create();
		}
		ds_list_add(Children, _child);
		_child.Parent = self;
		return self;
	};

	/// @func HasChildren()
	/// @desc Checks whether the element has child elements.
	/// @return {bool} Returns true if the element has child elements.
	static HasChildren = function () {
		gml_pragma("forceinline");
		if (Children == undefined)
		{
			return false;
		}
		return !ds_list_empty(Children);
	};

	/// @func GetChildCount()
	/// @desc Retrieves the number of child elements.
	/// @return {uint} The number of child elements.
	static GetChildCount = function () {
		gml_pragma("forceinline");
		if (Children == undefined)
		{
			return 0;
		}
		return ds_list_size(Children);
	};

	/// @func GetChild(_n)
	/// @desc Gets n-th child of the element.
	/// @param {uint} _n The index (0...{@link CE_XMLElement.GetChildCount} - 1) of
	/// the child element.
	/// @return {CE_XMLElement} The n-th child of the element.
	static GetChild = function (_n) {
		gml_pragma("forceinline");
		return Children[| _n];
	};

	/// @func IterChildren()
	/// @desc Creates a new iterator using which you can walk through all
	/// child elements of the element.
	/// @return {CE_ListIterator<CE_XMLElement>/CE_EmptyIterator} The created
	/// iterator.
	static IterChildren = function () {
		gml_pragma("forceinline");
		if (Children == undefined)
		{
			return new CE_EmptyIterator();
		}
		return new CE_ListIterator(Children);
	};

	/// @func HasAttributes()
	/// @desc Checks whether the element has attributes.
	/// @return {bool} Returns true if the element has attributes.
	static HasAttributes = function () {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return false;
		}
		return !ds_map_empty(Attributes);
	};

	/// @func GetAttributeCount(_element)
	/// @desc Gets the number of attributes of the element.
	/// @return {uint} The number of attributes of the element.
	static GetAttributeCount = function () {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return 0;
		}
		return ds_map_size(Attributes);
	};

	/// @func HasAttribute(_attribute)
	/// @desc Checks whether the element has an attribute with given name.
	/// @param {string} _attribute The name of the attribute.
	/// @return {bool} Returns true if the element has an attribute with given
	/// name.
	static HasAttribute = function (_attribute) {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return false;
		}
		return ds_map_exists(Attributes, _attribute);
	};

	/// @func FindFirstAttribute()
	/// @desc Finds the first attribute of the element.
	/// @return {string/undefined} The name of the first attribute or undefined
	/// if the element does not have any.
	static FindFirstAttribute = function () {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return undefined;
		}
		return ds_map_find_first(Attributes);
	};

	/// @func FindNextAttribute(_attribute)
	/// @desc Finds next element attribute.
	/// @param {string} _attribute Name of the current atribute.
	/// @return {string/undefined} Name of the next attribute or undefined if the
	/// element does not have more attributes.
	static FindNextAttribute = function (_attribute) {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return undefined;
		}
		return ds_map_find_next(Attributes, _attribute);
	};

	/// @func IterAttributes()
	/// @desc Creates a new iterator using which you can walk through all
	/// attributes of the element.
	/// @return {CE_MapIterator<string, string/real>/CE_EmptyIterator}
	/// The created iterator.
	static IterAttributes = function () {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return new CE_EmptyIterator();
		}
		return new CE_MapIterator(Attributes);
	};

	/// @func GetAttribute(_element, _attribute)
	/// @desc Gets value of the element attribute.
	/// @param {string} _attribute The name of the attribute.
	/// @return {real/string/undefined} The attribute value.
	static GetAttribute = function (_attribute) {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			return undefined;
		}
		return Attributes[? _attribute];
	};

	/// @func SetAttribute(_attribute, _value)
	/// @desc Sets value of the element attribute to the new value.
	/// @param {string} _attribute The name of the attribute.
	/// @param {real/string/undefined} _value The value of the attribute.
	/// @return {CE_XMLElement} Returns `self`.
	static SetAttribute = function (_attribute, _value) {
		gml_pragma("forceinline");
		if (Attributes == undefined)
		{
			Attributes = ds_map_create();
		}
		Attributes[? _attribute] = _value;
		return self;
	};

	/// @func RemoveAttribute(_element, _attribute)
	/// @desc Removes an attribute from the element.
	/// @param {string} _attribute The name of the attribute.
	/// @return {CE_XMLElement} Returns `self`.
	static RemoveAttribute = function (_element, _attribute) {
		gml_pragma("forceinline");
		if (Attributes != undefined)
		{
			ds_map_delete(Attributes, _attribute);
		}
		return self;
	};

	/// @func Matches(_filter)
	/// @desc Checks whether the filter matches the element.
	/// @param {func/struct} _filter Either a function which takes the element as
	/// the first argument and returns true if the element matches, or a struct
	/// containg at least one of properties `Name`, `Value`. If the elements
	/// properties match the filter properties, then the function returns true,
	/// otherwise false.
	/// @return {bool} Returns true if the element matches the filter.
	static Matches = function (_filter) {
		if (is_struct(_filter))
		{
			return (true
				&& (variable_struct_exists(_filter, "Name") ? (Name == _filter.Name) : true)
				&& (variable_struct_exists(_filter, "Value") ? (Value == _filter.Value) : true));
		}
		return _filter(self);
	};

	/// @func Find(_filter)
	/// @desc Searches through the element and its child elements for the first
	/// element matching the filter.
	/// @param {func/struct} _filter See {@link CE_XMLElement.Matches} for more info
	/// about filters.
	/// @return {CE_XMLElement/undefined} The found element or undefined.
	static Find = function (_filter) {
		if (Matches(_filter))
		{
			return self;
		}

		var _childCount = GetChildCount();

		for (var i = 0; i < _childCount; ++i)
		{
			var _foundElement = GetChild(i).Find(_filter);
			if (_foundElement != undefined)
			{
				return _foundElement;
			}
		}

		return undefined;
	};

	/// @func FindAll(_filter)
	/// @desc Searches through the element and its child elements for all elements
	/// matching the filter and returns them in a list.
	/// @param {func/struct} _filter See {@link CE_XMLElement.Matches} for more info
	/// about filters.
	/// @param {ds_list<CE_XMLElement>} [_list] A list to add the elements to. If
	/// not defined, then a new one is created. Don't forget to delete the list
	/// when it's not needed anymore!
	/// @return {ds_list<CE_XMLElement>} The list of found elements.
	static FindAll = function (_filter) {
		var _list = (argument_count > 1) ? argument[1] : ds_list_create();

		if (Matches(_filter))
		{
			ds_list_add(_list, self);
		}

		var _childCount = GetChildCount();

		for (var i = 0; i < _childCount; ++i)
		{
			GetChild(i).FindAll(_filter, _list);
		}

		return _list;
	};

	/// @func ToString([_indent])
	/// @desc Writes the element and its children into a string.
	/// @param {uint} [_indent] The current indentation level. Defaults to 0.
	/// @return {string} The resulting XML string.
	static ToString = function () {
		var _indent = (argument_count > 0) ? argument[0] : 0;

		var _childCount = GetChildCount();
		var _spaces = string_repeat(" ", _indent * 2);

		// Open element
		var _string = _spaces + "<" + Name;

		// Attributes
		if (HasAttributes())
		{
			var _attribute = FindFirstAttribute();
			repeat (GetAttributeCount())
			{
				_string += " " + string(_attribute) + "=\""
					+ CE_XMLValueToString(GetAttribute(_attribute))
					+ "\"";
				_attribute = FindNextAttribute(_attribute);
			}
		}

		if (_childCount == 0 && Value == undefined)
		{
			_string += "/";
		}

		_string += ">";

		if (_childCount != 0 || Value == undefined)
		{
			_string += chr(10);
		}

		// Children
		for (var i = 0; i < _childCount; ++i)
		{
			_string += GetChild(i).ToString(_indent + 1);
		}

		// Close element
		if (_childCount != 0)
		{
			_string += _spaces + "</" + Name + ">" + chr(10);
		}
		else if (Value != undefined)
		{
			_string += CE_XMLValueToString(Value);
			_string += "</" + Name + ">" + chr(10);
		}

		return _string;
	};

	static Destroy = function () {
		method(self, Super_Class.Destroy)();

		// Remove from parent
		if (Parent != undefined)
		{
			Remove();
		}

		// Destroy children
		for (var i = GetChildCount() - 1; i >= 0; --i)
		{
			var _child = GetChild(i);
			_child.Parent = undefined;
			_child.Destroy();
		}

		// Free resources from memory
		if (Children != undefined)
		{
			ds_list_destroy(Children);
			Children = undefined;
		}

		if (Attributes != undefined)
		{
			ds_map_destroy(Attributes);
			Attributes = undefined;
		}
	};
}