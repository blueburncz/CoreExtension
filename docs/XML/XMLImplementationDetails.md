# Implementation details
* The parser does a minimal amount of error checking. The parsing process fails only when a symbol `<` or `>` occurs when not expected.
* The parser automatically detects value types. That means real numbers and integers are stored as a real, anything else as a string.
* When reading an XML file, special characters are automatically replaced by their original form (see the table below).
* When writing an XML file, all special characters in values are automatically escaped (see the table below).
* Every element starting with `?` or `!` is ignored by the parser.
* Elements with an inner value should not have any child elements and vice versa.

Following is a translation table of all special characters.

Special character | Escaped form | Replaced by
----------------- | -------------| -----------
Ampersand         | `&amp;`      | `&`
Less-than         | `&lt;`       | `<`
Greater-than      | `&gt;`       | `>`
Quotes            | `&quot;`     | `"`
Apostrophe        | `&apos;`     | `'`