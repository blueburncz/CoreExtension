/// @func CE_DeltaTime()
/// @extends CE_DeltaTime
function CE_DeltaTime()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {real} Control how fast the game plays. This could be used for
	/// slow motion effect (values less than 1.0) or to pause the game (0.0).
	static GameSpeed = 1.0;

	/// @func GetMicroseconds()
	/// @desc Retrieves microseconds passed since the last frame.
	/// @return {real} Number of microseconds passed since the last frame.
	/// @note This is affected by {@link CE_DeltaTime.GameSpeed}!
	/// @see CE_DeltaTime.GameSpeed
	static GetMicroseconds = function () {
		gml_pragma("forceinline");
		return (delta_time * GameSpeed);
	};

	/// @func GetMilliseconds()
	/// @desc Retrieves milliseconds passed since the last frame.
	/// @return {real} Number of milliseconds passed since the last frame.
	/// @note This is affected by {@link CE_DeltaTime.GameSpeed}!
	/// @see CE_DeltaTime.GameSpeed
	static GetMilliseconds = function () {
		gml_pragma("forceinline");
		return ((delta_time * GameSpeed) / 1000.0);
	};

	/// @func GetSeconds()
	/// @desc Retrieves seconds passed since the last frame.
	/// @return {real} Number of seconds passed since the last frame.
	/// @note This is affected by {@link CE_DeltaTime.GameSpeed}!
	/// @see CE_DeltaTime.GameSpeed
	static GetSeconds = function () {
		gml_pragma("forceinline");
		return ((delta_time * GameSpeed) / 1000000.0);
	};

	/// @func GetMinutes()
	/// @desc Retrieves minutes passed since the last frame.
	/// @return {real} Number of minutes passed since the last frame.
	/// @note This is affected by {@link CE_DeltaTime.GameSpeed}!
	/// @see CE_DeltaTime.GameSpeed
	static GetMinutes = function () {
		gml_pragma("forceinline");
		return ((delta_time * GameSpeed) / 60000000.0);
	};

	/// @func GetHours()
	/// @desc Retrieves hours passed since the last frame.
	/// @return {real} Number of hours passed since the last frame.
	/// @note This is affected by {@link CE_DeltaTime.GameSpeed}!
	/// @see CE_DeltaTime.GameSpeed
	static GetHours = function () {
		gml_pragma("forceinline");
		return ((delta_time * GameSpeed) / 3600000000.0);
	};
}