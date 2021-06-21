/// @enum XML delimiters.
/// @private
enum CE_EXmlChars
{
	/// @member Null character.
	Null = 0,
	/// @member Line feed.
	LF = 10,
	/// @member Carriage return.
	CR = 13,
	/// @member Space.
	Space = 32,
	/// @member Exclamation mark.
	EM = 33,
	/// @member Double quote.
	DQ = 34,
	/// @member Single quote.
	SQ = 39,
	/// @member Slash.
	Slash = 47,
	/// @member Less-than sign.
	LT = 60,
	/// @member Equals sign.
	Equal = 61,
	/// @member Greater-than sign.
	GT = 62,
	/// @member Question mark.
	QM = 63
};

/// @func CE_XmlElement([_name[, value]])
/// @desc Represents a tag within an XML document.
/// @param {string} [_name] The name of the element. Defaults to an empty string.
/// @param {string/real/bool/undefined} [_value] The element value. Defaults to
/// `undefined`.
function CE_XmlElement() constructor
{
	/// @var {string} The name of the element.
	/// @readonly
	Name = (argument_count > 0) ? argument[0] : "";

	/// @var {string/real/bool/undefined} The element's value. If `undefined`,
	/// then the element does not have a value.
	/// @readonly
	Value = (argument_count > 1) ? argument[1] : undefined;

	/// @var {ds_map<string, string/real/bool>} A map of element's attributes.
	/// @readonly
	Attributes = ds_map_create();

	/// @var {CE_XmlElement/undefined} The parent of this element. If `undefined`,
	/// then this is a root element.
	/// @readonly
	Parent = undefined;

	/// @var {ds_list<CE_XmlElement>} A list of child elements.
	/// @readonly
	Children = ds_list_create();

	/// @func SetAttribute(_name, _value)
	/// @param {string} _name The name of the attribute.
	/// @param {string/real/bool/undefined} _value The attribute value.
	/// @return {CE_XmlElement} Returns `self` to allow method chaining.
	static SetAttribute = function (_name, _value) {
		gml_pragma("forceinline");
		Attributes[? _name] = _value;
		return self;
	};

	/// @func HasAttribute([_name])
	/// @param {string} [_name] The name of the attribute.
	/// @return {bool} Returns `true` if the element has the attribute.
	static HasAttribute = function () {
		gml_pragma("forceinline");
		if (argument_count == 0)
		{
			return !ds_map_empty(Attributes);
		}
		return ds_map_exists(Attributes, argument[0]);
	};

	/// @func GetAttributeCount()
	/// @return {int} Returns number of attributes of the element.
	static GetAttributeCount = function () {
		return ds_map_size(Attributes);
	};

	/// @func GetAttribute(_name)
	/// @param {string} _name The name of the attribute.
	/// @return {string/real/bool/undefined} The attribute value.
	static GetAttribute = function (_name) {
		gml_pragma("forceinline");
		return Attributes[? _name];
	};

	/// @func FindFirstAttribute()
	/// @return {string} The name of the first attribute.
	static FindFirstAttribute = function () {
		return ds_map_find_first(Attributes);
	};

	/// @func FindPrevAttribute(_name)
	/// @param {string} _name The name of the current attribute.
	/// @return {string} The name of the previous attribute.
	static FindPrevAttribute = function (_name) {
		return ds_map_find_previous(Attributes, _name);
	};

	/// @func FindNextAttribute(_name)
	/// @param {string} _name The name of the current attribute.
	/// @return {string} The name of the next attribute.
	static FindNextAttribute = function (_name) {
		return ds_map_find_next(Attributes, _name);
	};

	/// @func RemoveAttribute(_name)
	/// @param {string} _name The name of the attribute.
	/// @return {CE_XmlElement} Returns `self` to allow method chaining.
	static RemoveAttribute = function (_name) {
		ds_map_delete(Attributes, _name);
		return self;
	};

	/// @func AddChild(_child)
	/// @param {CE_XmlElement} _child The child element.
	/// @return {CE_XmlElement} Returns `self` to allow mathod chaining.
	static AddChild = function (_child) {
		gml_pragma("forceinline");
		ds_list_add(Children, _child);
		_child.Parent = self;
		return self;
	};

	/// @func HasChildren()
	/// @return {bool} Returns `true` if the element has child elements.
	static HasChildren = function () {
		gml_pragma("forceinline");
		return !ds_list_empty(Children);
	};

	/// @func GetChildCount()
	/// @return {int} Returns number of child elements.
	static GetChildCount = function () {
		gml_pragma("forceinline");
		return ds_list_size(children);
	};

	/// @func GetChild(_index)
	/// @param {int} _index The index of the child element.
	/// @return {CE_XmlElement} Returns a child element with given index.
	/// @see CE_XmlElement.HasChildren
	/// @see CE_XmlElement.GetChildCount
	static GetChild = function (_index) {
		gml_pragma("forceinline");
		return Children[| _index];
	};

	/// @func Destroy()
	/// @desc Frees memory used by the element. Use this in combination with
	/// `delete` to Destroy the struct.
	/// @example
	/// ```gml
	/// element.Destroy();
	/// delete element;
	/// ```
	static Destroy = function () {
		var i = 0;
		repeat (ds_list_size(children))
		{
			Children[| i++].Destroy();
		}
		ds_list_destroy(Children);
		ds_map_destroy(Attributes);
	};
}

/// @func CE_XmlDocument()
/// @desc An XML document.
function CE_XmlDocument() constructor
{
	/// @var {string/undefined} Path to the XML file. It is `undefined` until the
	/// document is saved or loaded.
	/// @see CE_XmlDocument.Save
	/// @see CE_XmlDocument.Load
	/// @readonly
	Path = undefined;

	/// @var {CE_XmlElement/undefined} The root element.
	Root = undefined;

	/// @func Parse(_string)
	/// @desc Parses a value from a string.
	/// @param {string} string The string to parse.
	/// @return {string/real/bool} Real value or a string, where XML character entities
	/// are replaced with their original form.
	/// @private
	static Parse = function (_string) {
		// Clear whitespace, replace character entities
		while (string_byte_at(_string, 1) == 32)
		{
			_string = string_delete(_string, 1, 1);
		}

		_string = string_replace_all(_string, "&lt;", "<");
		_string = string_replace_all(_string, "&gt;", ">");
		_string = string_replace_all(_string, "&quot;", "\"");
		_string = string_replace_all(_string, "&apos;", "'");
		_string = string_replace_all(_string, "&amp;", "&");

		// Parse real
		var _real = ce_parse_real(_string);
		if (!is_nan(_real))
		{
			return _real;
		}

		// Bools
		if (_string == "true")
		{
			return true;
		}
		if (_string == "false")
		{
			return false;
		}

		return _string;
	};

	/// @func Unparse(_value)
	/// @desc Turns given value into a string. Replaces characters with their
	/// XML-safe form.
	/// @param {any} _value The value to be turned into a string.
	/// @return {string} The resulting string.
	/// @private
	static Unparse = function (_value) {
		if (is_bool(_value))
		{
			return _value ? "true" : "false";
		}

		if (is_real(_value))
		{
			return ce_real_to_string(_value);
		}

		if (is_string(_value))
		{
			_value = string_replace_all(_value, "&", "&amp;");
			_value = string_replace_all(_value, "<", "&lt;");
			_value = string_replace_all(_value, ">", "&gt;");
			_value = string_replace_all(_value, "'", "&apos;");
			_value = string_replace_all(_value, "\"", "&quot;");
		}

		return string(_value);
	};

	/// @func Load(_path)
	/// @desc Loads an XML document from a file.
	/// @param {string} _path The path to the file to load.
	/// @return {CE_XmlDocument} Returns `self` to allow method chaining.
	/// @throws {CE_Error) If the loading fails.
	static Load = function (_path) {
		var _file = file_bin_open(_path, 0);
		if (_file == -1)
		{
			throw new CE_Error("Could on open file " + _path + "!");
		}

		var _filePos = 0;
		var _fileSize = file_bin_size(_file);
		var _byte = CE_EXmlChars.Space;
		var _isSeparator = true;
		var _token = "";
		var _isString = false;
		var _attributeName = "";
		var _root = undefined;
		var _element = undefined;
		var _lastElement = undefined;
		var _parentElement = undefined;
		var _isClosing = false;
		var _isComment = false;
		var _lastByte;

		do
		{
			// Read byte from file
			_lastByte = _byte;
			_byte = file_bin_read_byte(_file);

			// Process byte
			_isSeparator = true;

			switch (_byte)
			{
			// Start of new element
			case CE_EXmlChars.LT:
				if (_element != undefined)
				{
					if (_root != undefined)
					{
						_root.Destroy();
						delete _root;
					}
					throw new CE_Error("Unexpected symbol '<' at "
						+ string(_filePos) + "!");
				}

				// Set element value
				while (string_byte_at(_token, 1) == 32)
				{
					_token = string_delete(_token, 1, 1);
				}

				if (_token != ""
					&& _parentElement != undefined
					&& _parentElement.GetChildCount() == 0)
				{
					_parentElement.Value = Parse(_token);
				}

				_element = new CE_XmlElement();
				break;

			// End of element
			case CE_EXmlChars.GT:
				if (_element == undefined)
				{
					if (_root != undefined)
					{
						_root.Destroy();
						delete _root;
					}
					throw new CE_Error("Unexpected symbol '>' at "
						+ string(_filePos) + "!");
				}

				_lastElement = _element;

				if (_root == undefined && !_isComment)
				{
					_root = _element;
				}

				if (_isComment)
				{
					_lastElement = undefined;
					_element.Destroy();
					delete _element;
					_isComment = false;
				}
				else if (_lastByte == CE_EXmlChars.Slash)
				{
					// Self-closing element
					if (_parentElement != undefined)
					{
						_parentElement.AddChild(_element);
					}
				}
				else if (_isClosing)
				{
					// If the element is not self-closing and it does not
					// have a value defined, then Set its value to an empty string.
					if (_parentElement.Value == undefined
						&& _parentElement.GetChildCount() == 0)
					{
						_parentElement.Value = "";
					}
					_parentElement = _parentElement.Parent;
					_lastElement = undefined;
					_element.Destroy();
					delete _element;
					_isClosing = false;
				}
				else
				{
					if (_parentElement != undefined)
					{
						_parentElement.AddChild(_element);
					}
					_parentElement = _element;
				}
				_element = undefined;
				break;

			// Closing element
			case CE_EXmlChars.Slash:
				if (_isString || _element == undefined)
				{
					_isSeparator = false;
				}
				else if (_lastByte == CE_EXmlChars.LT)
				{
					_isClosing = true;
				}
				break;

			// Attribute
			case CE_EXmlChars.Equal:
				if (!_isString)
				{
					if (_token != "")
					{
						_attributeName = _token;
					}
				} else {
					_isSeparator = false;
				}
				break;

			// Start/end of string
			case CE_EXmlChars.SQ:
			case CE_EXmlChars.DQ:
				if (_isString == _byte)
				{
					_isString = false;
					// Store attribute
					if (_attributeName != "")
					{
						if (_element != undefined)
						{
							_element.SetAttribute(_attributeName, Parse(_token));
						}
						_attributeName = "";
					}
				}
				else if (!_isString)
				{
					_isString = _byte;
				}
				break;

			// Treat as comments
			case CE_EXmlChars.QM:
			case CE_EXmlChars.EM:
				if (_lastByte == CE_EXmlChars.LT)
				{
					_isComment = true;
				}
				else
				{
					_isSeparator = false;
				}
				break;

			default:
				// Whitespace
				if (!_isString && _element != undefined
					&& ((_byte > CE_EXmlChars.Null && _byte <= CE_EXmlChars.CR)
					|| _byte == CE_EXmlChars.Space))
				{
					// Do nothing...
				}
				else
				{
					_isSeparator = false;
				}
				break;
			}

			// Process tokens
			if (_isSeparator)
			{
				// End of token
				if (_token != "")
				{
					// Set element name
					if (_element != undefined && _element.Name == "")
					{
						_element.Name = _token;
					}
					else if (_lastElement != undefined
						&& _lastElement.Name == "")
					{
						_lastElement.Name = _token;
					}
					_token = "";
				}
			}
			else
			{
				// Build token
				if (_byte > CE_EXmlChars.Null && _byte <= CE_EXmlChars.CR)
				{
					// Replace new lines, tabs, etc. with spaces
					_byte = CE_EXmlChars.Space;
				}
				_token += chr(_byte);
			}
		}
		until (++_filePos == _fileSize);

		file_bin_close(_file);

		Path = _path;
		Root = _root;
		return self;
	};

	/// @func ToString()
	/// @desc Prints the document into a string.
	/// @return {string} The created string.
	static ToString = function () {
		var _element = (argument_count > 0) ? argument[0] : Root;
		var _name = _element.Name;
		var _attributeCount = _element.GetAttributeCount();
		var _childCount = _element.GetChildCount();
		var _value = _element.Value;
		var _indent = (argument_count > 1) ? argument[1] : 0;
		var _spaces = string_repeat(" ", _indent * 2);

		// Open element
		var _string = _spaces + "<" + _name;

		// Attributes
		var _attribute = _element.FindFirstAttribute();

		repeat (_attributeCount)
		{
			_string += " " + string(_attribute) + "=\""
				+ Unparse(_element.GetAttribute(_attribute))
				+ "\"";
			_attribute = _element.FindNextAttribute(_attribute);
		}

		if (_childCount == 0 && is_undefined(_value))
		{
			_string += "/";
		}

		_string += ">";

		if (_childCount != 0 || is_undefined(_value))
		{
			_string += chr(10);
		}

		// Children
		for (var i = 0; i < _childCount; ++i)
		{
			var _childElement = _element.GetChild(i);
			_string += ToString(_childElement, _indent + 1);
		}

		// Close element
		if (_childCount != 0)
		{
			_string += _spaces + "</" + _element.Name + ">" + chr(10);
		}
		else if (!is_undefined(_value))
		{
			_string += Unparse(_value);
			_string += "</" + _element.Name + ">" + chr(10);
		}

		return _string;
	};

	/// @func Save([_path])
	/// @desc Saves the document to a file.
	/// @param {string} [_path] The file path. Defaults to {@link CE_XmlDocument.Path}.
	/// @return {CE_XmlDocument} Returns `self` to allow method chaining.
	/// @throws {CE_Error} If the Save path is not defined.
	static Save = function () {
		var _path = (argument_count > 0) ? argument[0] : Path;
		if (_path == undefined)
		{
			throw new CE_Error("Save path not defined!");
		};
		Path = _path;

		var _file = file_text_open_write(_path);
		if (_file == -1)
		{
			throw new CE_Error();
		}
		file_text_write_string(_file, ToString());
		file_text_writeln(_file);
		file_text_close(_file);

		return self;
	};

	/// @func Destroy()
	/// @desc Frees memory used by the document. Use this in combination with
	/// `delete` to Destroy the struct.
	/// @example
	/// ```gml
	/// document.Destroy();
	/// delete document;
	/// ```
	static Destroy = function () {
		if (Root != undefined)
		{
			Root.Destroy();
			delete Root;
		}
	};
}