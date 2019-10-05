# Changelog 1.3.1
* Added new script `ce_parse_real` which parses a real number from a string. This function returns `NaN` if given string does not represent a number instead of ending the game with an error.
* Added new script `ce_real_to_string` which converts a real value to a string without generating trailing zeros after a decimal point.
* Updated `ce_xml_read` to use the new `ce_parse_real` script for parsing element attributes.
* Updated `ce_xml_string` to use the new `ce_real_to_string` script.
* Moved *Types* folder from *Core* back to *Utils*, since it contains only `ce_is_nan`, which GML already supports.