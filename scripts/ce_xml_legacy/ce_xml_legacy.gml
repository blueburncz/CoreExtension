/// @func ce_xml_elem_add_child(element, child)
/// @desc Adds child to the given element.
/// @param {CE_XMLElement} _element The element to add the child to.
/// @param {CE_XMLElement} _child The child element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.AddChild} instead.
function ce_xml_elem_add_child(_element, _child)
{
	gml_pragma("forceinline");
	_element.AddChild(_child);
}

/// @func ce_xml_elem_create([_name])
/// @desc Creates a new element.
/// @param {string} [_name] The name of the element. Defaults to an empty string.
/// @return {CE_XMLElement} The created element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement} instead.
function ce_xml_elem_create(_name)
{
	gml_pragma("forceinline");
	return new CE_XMLElement(_name);
}

/// @func ce_xml_elem_destroy(_element)
/// @desc Destroys the element and all its children.
/// @param {CE_XMLElement} _element The element to be destroyed.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Destroy} instead.
function ce_xml_elem_destroy(_element)
{
	gml_pragma("forceinline");
	_element.Destroy();
}

/// @func ce_xml_elem_find(_rootElement, _name)
/// @desc Finds the first element with given name in the given tree of elements.
/// @param {CE_XMLElement} _rootElement The root element of the tree.
/// @param {string} _name The name of the element to be found.
/// @return {CE_XMlElement/noone} The found element or noone, if no such element
/// has been found.
function ce_xml_elem_find(_rootElement, _name)
{
	gml_pragma("forceinline");
	throw new CE_NotImplementedError();
}

/// @func ce_xml_elem_find_all(_rootElement, _name)
/// @desc Finds all elements with given name in the given tree of elements.
/// @param {CE_XMLElement} _rootElement The root element of the tree.
/// @param {string} _name The name of elements to be found.
/// @return {ds_list} A list containing all found elements.
function ce_xml_elem_find_all(_rootElement, _name)
{
	gml_pragma("forceinline");
	throw new CE_NotImplementedError();
}

/// @func ce_xml_elem_find_first_attribute(_element)
/// @desc Finds the first attribute of the given element.
/// @param {CE_XMLElement} _element The element.
/// @return {string/undefined} The name of the first attribute or undefined, if
/// the element does not have any.
function ce_xml_elem_find_first_attribute(_element)
{
	gml_pragma("forceinline");
	return _element.FindFirstAttribute();
}

/// @func ce_xml_elem_find_next_attribute(_element, _attribute)
/// @desc Finds next element attribute.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _attribute Name of the current atribute.
/// @return {string/undefined} Name of the next attribute or undefined, if the
/// element does not have more attributes.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.FindNextAttribute} instead.
function ce_xml_elem_find_next_attribute(_element, _attribute)
{
	gml_pragma("forceinline");
	return _element.FindNextAttribute(_attribute);
}

/// @func ce_xml_elem_get_attribute(_element, _attribute)
/// @desc Gets value of the element attribute.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _attribute The name of the attribute.
/// @return {real/string/undefined} The attribute value.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.GetAttribute} instead.
function ce_xml_elem_get_attribute(_element, _attribute)
{
	gml_pragma("forceinline");
	return _element.GetAttribute(_attribute);
}

/// @func ce_xml_elem_get_attribute_count(_element)
/// @desc Gets the number of attributes of the given element.
/// @param {real} _element The element.
/// @return {uint} The number of attributes of the given element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.GetAttributeCount} instead.
function ce_xml_elem_get_attribute_count(_element)
{
	gml_pragma("forceinline");
	return _element.GetAttributeCount();
}

/// @func ce_xml_elem_get_child(_element, _n)
/// @desc Gets n-th child of the given element.
/// @param {CE_XMLElement} _element The element.
/// @param {uint} _n The index (0...numberOfChildren - 1) of the child
/// element.
/// @return {CE_XMLElement} The n-th child of the given element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.GetChild} instead.
function ce_xml_elem_get_child(_element, _n)
{
	gml_pragma("forceinline");
	return _element.GetChild(_n);
}

/// @func ce_xml_elem_get_child_count(_element)
/// @desc Gets number of children of the given element.
/// @param {CE_XMLElement} _element The element.
/// @return {uint} Number of children of the given element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.GetChildCount} instead.
function ce_xml_elem_get_child_count(_element)
{
	gml_pragma("forceinline");
	return _element.GetChildCount();
}

/// @func ce_xml_elem_get_name(_element)
/// @desc Gets the name of the element.
/// @param {CE_XMLElement} _element The element.
/// @return {string} The name of the element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Name} instead.
function ce_xml_elem_get_name(_element)
{
	gml_pragma("forceinline");
	return _element.Name();
}

/// @func ce_xml_elem_get_parent(_element)
/// @desc Gets the parent of the given element.
/// @param {CE_XMLElement} _element The element.
/// @return {CE_XMLElement/noone} The parent of the element or noone, if the element
/// does not have a parent.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Parent} instead.
function ce_xml_elem_get_parent(_element)
{
	gml_pragma("forceinline");
	return (_element.Parent != undefined)
		? _element.Parent
		: noone;
}

/// @func ce_xml_elem_get_value(_element)
/// @desc Gets the value of the given element.
/// @param {CE_XMLElement} _element The element.
/// @return {real/string/undefined} The element value or undefined, if the
/// element does not have any value.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Value} instead.
function ce_xml_elem_get_value(_element)
{
	gml_pragma("forceinline");
	return _element.Value;
}

/// @func ce_xml_elem_has_attribute(_element, _attribute)
/// @desc Finds the attribute with given name in the element.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _attribute The name of the attribute.
/// @return {boolean} True if the element has an attribute with given name.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.HasAttribute} instead.
function ce_xml_elem_has_attribute(_element, _attribute)
{
	gml_pragma("forceinline");
	return _element.HasAttribute(_attribute);
}

/// @func ce_xml_elem_has_value(_element)
/// @desc Finds out if the given element has a value.
/// @param {CE_XMLElement} _element The element.
/// @return {boolean} True if the element has a value.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Value} instead.
function ce_xml_elem_has_value(_element)
{
	gml_pragma("forceinline");
	return (_element.Value != undefined);
}

/// @func ce_xml_elem_remove_attribute(_element, _attribute)
/// @desc Removes given attribute from the element.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _attribute The name of the attribute.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.RemoveAttribute} instead.
function ce_xml_elem_remove_attribute(_element, _attribute)
{
	gml_pragma("forceinline");
	return _element.RemoveAttribute(_attribute);
}

/// @func ce_xml_elem_set_attribute(_element, _attribute, _value)
/// @desc Sets value of the given element attribute to the given value.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _attribute The name of the attribute.
/// @param {real/string/undefined} _value The value of the attribute.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.SetAttribute} instead.
function ce_xml_elem_set_attribute(_element, _attribute, _value)
{
	gml_pragma("forceinline");
	return _element.SetAttribute(_attribute, _value);
}

/// @func ce_xml_elem_set_name(_element, _name)
/// @desc Sets name of the element to the given value.
/// @param {CE_XMLElement} _element The element.
/// @param {string} _name The new name of the element.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Name} instead.
function ce_xml_elem_set_name(_element, _name)
{
	gml_pragma("forceinline");
	_element.Name = _name;
}

/// @func ce_xml_elem_set_value(_element, _value)
/// @desc Sets value of the element to the given value.
/// @param {CE_XMLElement} _element The element.
/// @param {real/string/undefined} _value The new element value.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLElement.Value} instead.
function ce_xml_elem_set_value(_element, _value)
{
	gml_pragma("forceinline");
	_element.Value = _value;
}

/// @func ce_xml_read(_fileName)
/// @desc Reads the XML formatted file and stores the contained data into a
/// tree of elements.
/// @param {string} _fileName The name of the XML formatted file.
/// @return {CE_XMLElement/noone} The root element on success or noone on fail.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLDocument.Load} instead.
function ce_xml_read(_fileName)
{
	gml_pragma("forceinline");
	try
	{
		return new CE_XMLDocument().Load(_fileName).Root;
	}
	catch (_ignore)
	{
		return noone;
	}
}

/// @func ce_xml_write(_rootElement[, _indent])
/// @desc Writes the tree of XML elements into a string.
/// @param {CE_XMLElement} _rootElement The root element of the tree.
/// @param {uint} [_indent] The current indentation level. Defaults to 0.
/// @return {string} The resulting string.
/// @deprecated This function exists only for backwards-compatibility reasons.
/// Please use {@link CE_XMLDocument.ToString} instead.
function ce_xml_write(_rootElement)
{
	gml_pragma("forceinline");
	var _indent = (argument_count > 1) ? argument[1] : 0;
	return _rootElement.ToString(_indent);
}