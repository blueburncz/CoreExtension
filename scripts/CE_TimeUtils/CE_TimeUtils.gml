/// @func CE_HoursToMilliseconds(_hours)
/// @param {real} _hours Hours to be converted to milliseconds.
/// @return {real} Hours converted to milliseconds.
function CE_HoursToMilliseconds(_hours)
{
	gml_pragma("forceinline");
	return (_hours * 3600000.0);
}

/// @func CE_MinutesToMilliseconds(_minutes)
/// @param {real} _minutes Minutes to be converted to milliseconds.
/// @return {real} Minutes converted to milliseconds.
function CE_MinutesToMilliseconds(_minutes)
{
	gml_pragma("forceinline");
	return (_minutes * 60000.0);
}

/// @func CE_SecondsToMilliseconds(_seconds)
/// @param {real} _seconds Seconds to be converted to milliseconds.
/// @return {real} Seconds converted to milliseconds.
function CE_SecondsToMilliseconds(_seconds)
{
	gml_pragma("forceinline");
	return (_seconds * 1000.0);
}

/// @func CE_PerSecond(_value)
/// @param {real} value The value to convert.
/// @return {real} The converted value.
/// @example
/// This will make the calling instance move to the right by 32px per second,
/// independently on the framerate.
/// ```gml
/// x += CE_PerSecond(32);
/// ```
function CE_PerSecond(_value)
{
	gml_pragma("forceinline");
	return (_value * delta_time * 0.000001);
}