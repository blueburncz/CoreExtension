/// @enum An enumeration of XML characters.
/// @private
enum CE_EXMLChar
{
	Null = 0,
	LF = 10,
	CR = 13,
	Space = 32,
	EM = 33,    // !
	DQ = 34,    // "
	SQ = 39,    // '
	Slash = 47,
	LT = 60,    // <
	Equal = 61, // =
	GT = 62,    // >
	QM = 63,    // ?
};

/// @func CE_XMLDocument()
/// @extends CE_Class
/// @desc An XML document.
function CE_XMLDocument()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	/// @var {string/undefined} Path to the XML file. It is undefined until the
	/// document is saved or loaded.
	/// @see CE_XMLDocument.Save
	/// @see CE_XMLDocument.Load
	/// @readonly
	Path = undefined;

	/// @var {CE_XMLElement/undefined} The root element of the XML document.
	Root = undefined;

	/// @func Load(_path)
	/// @desc Loads an XML document from a file.
	/// @param {string} _path The path to the file to load.
	/// @return {CE_XMLDocument} Returns `self`.
	/// @throws {CE_IOError} If the file could not be loaded.
	/// @example
	/// Example "conf.xml" containing window width and height:
	/// ```xml
	/// <conf>
	///     <window>
	///         <width>1920</width>
	///         <height>1080</height>
	///     </window>
	/// </conf>
	/// ```
	/// Code that loads window width and height from the conf:
	/// ```gml
	/// try
	/// {
	///     var _conf = new CE_XMLDocument().Load("conf.xml");
	///     var _window = _conf.Root.Find({ Name: "window" });
	///     var _windowWidth = _window.Find({ Name: "width" }).Value;
	///     var _windowHeight = _window.Find({ Name: "height" }).Value;
	///     window_set_size(_windowWidth, _windowHeight);
	///     _conf.Destroy();
	/// }
	/// catch (_e)
	/// {
	///     // TODO: Handle exceptions...
	/// }
	/// ```
	static Load = function (_path) {
		var _file = file_bin_open(_path, 0);

		if (_file == -1)
		{
			throw new CE_IOException("Could not open file " + _path + "!");
		}

		var _filePos = 0;
		var _fileSize = file_bin_size(_file);
		var _byte = CE_EXMLChar.Space;
		var _lastByte;
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
			case CE_EXMLChar.LT:
				if (_element != undefined)
				{
					if (_root != undefined)
					{
						_root.Destroy();
					}
					throw new CE_Exception("Unexpected symbol '<' at " + string(_filePos) + "!");
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
					_parentElement.Value = CE_XMLValueFromString(_token);
				}

				_element = new CE_XMLElement();
				break;

			// End of element
			case CE_EXMLChar.GT:
				if (_element == undefined)
				{
					if (_root != undefined)
					{
						_root.Destroy();
					}
					throw new CE_Exception("Unexpected symbol '>' at " + string(_filePos) + "!");
				}

				_lastElement = _element;

				if (_root == undefined
					&& !_isComment)
				{
					_root = _element;
				}

				if (_isComment)
				{
					_lastElement = undefined;
					_element.Destroy();
					_isComment = false;
				}
				else if (_lastByte == CE_EXMLChar.Slash)
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
					// have a value defined, then set its value to an empty string.
					if (_parentElement.Value == undefined
						&& _parentElement.GetChildCount() == 0)
					{
						_parentElement.Value = "";
					}
					_parentElement = _parentElement.Parent;
					_lastElement = undefined;
					_element.Destroy();
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
			case CE_EXMLChar.Slash:
				if (_isString || _element == undefined)
				{
					_isSeparator = false;
				}
				else if (_lastByte == CE_EXMLChar.LT)
				{
					_isClosing = true;
				}
				break;

			// Attribute
			case CE_EXMLChar.Equal:
				if (!_isString)
				{
					if (_token != "")
					{
						_attributeName = _token;
					}
				}
				else
				{
					_isSeparator = false;
				}
				break;

			// Start/end of string
			case CE_EXMLChar.SQ:
			case CE_EXMLChar.DQ:
				if (_isString == _byte)
				{
					_isString = false;
					// Store attribute
					if (_attributeName != "")
					{
						if (_element != undefined)
						{
							_element.SetAttribute(_attributeName, CE_XMLValueFromString(_token));
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
			case CE_EXMLChar.QM:
			case CE_EXMLChar.EM:
				if (_lastByte == CE_EXMLChar.LT)
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
					&& ((_byte > CE_EXMLChar.Null && _byte <= CE_EXMLChar.CR)
					|| _byte == CE_EXMLChar.Space))
				{
					// ...
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
					else if (_lastElement != undefined && _lastElement.Name == "")
					{
						_lastElement.Name = _token;
					}
					_token = "";
				}
			}
			else
			{
				// Build token
				if (_byte > CE_EXMLChar.Null && _byte <= CE_EXMLChar.CR)
				{
					_byte = CE_EXMLChar.Space; // Replace new lines, tabs, etc. with spaces
				}
				_token += chr(_byte);
			}
		}
		until (++_filePos == _fileSize);

		file_bin_close(_file);

		Root = _root;
		Path = _path;

		return self;
	};

	/// @func ToString()
	/// @desc Writes the XML document into a string.
	/// @return {string} The resulting string.
	static ToString = function () {
		gml_pragma("forceinline");
		return Root.ToString();
	};

	/// @func Save([_path])
	/// @desc Saves the XML document into a file.
	/// @param {string} [_path] The file path. Defaults to {@link CE_XMLDocument.Path}.
	/// @return {CE_XMLDocument} Returns `self`.
	/// @throws {CE_ArgumentException} If the save path is not defined.
	/// @throws {CE_IOException} If writing to the file fails.
	/// @example
	/// ```gml
	/// try
	/// {
	///     var _conf = new CE_XMLDocument();
	///     _conf.Root = new CE_XMLElement("conf", [
	///         new CE_XMLElement("window", [
	///             new CE_XMLElement("width", window_get_width()),
	///             new CE_XMLElement("height", window_get_height())
	///         ])
	///     ]);
	///     _conf.Save("conf.xml");
	///     _conf.Destroy();
	/// }
	/// catch (_e)
	/// {
	///     // TODO: Handle exception...
	/// }
	/// ```
	/// The code above could output an XML file "conf.xml" looking like this:
	/// ```xml
	/// <conf>
	///     <window>
	///         <width>1920</width>
	///         <height>1080</height>
	///     </window>
	/// </conf>
	/// ```
	static Save = function (_path=Path) {
		if (_path == undefined)
		{
			throw new CE_ArgumentException("_path");
		}
		Path = _path;

		var _file = file_text_open_write(_path);
		if (_file == -1)
		{
			throw new CE_IOException();
		}
		file_text_write_string(_file, ToString());
		file_text_writeln(_file);
		file_text_close(_file);

		return self;
	};

	static Destroy = function () {
		method(self, Super_Class.Destroy)();
		if (Root != undefined)
		{
			Root.Destroy();
			Root = undefined;
		}
	};
}