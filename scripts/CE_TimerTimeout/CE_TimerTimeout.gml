/// @func CE_TimerTimeout(_callback, _duration)
/// @param {func} _callback
/// @param {uint} _duration
function CE_TimerTimeout(_callback, _duration) constructor
{
	/// @var {func}
	/// @readonly
	Callback = _callback;

	/// @var {uint}
	/// @readonly
	Start = current_time;

	/// @var {uint}
	/// @readonly
	Duration = _duration;

	/// @var {bool}
	/// @readonly
	Canceled = false;

	/// @func Cancel()
	/// @desc Cancels the timeout.
	/// @return {CE_TimerTimeout} Return self.
	static Cancel = function () {
		gml_pragma("forceinline");
		Canceled = true;
		return self;
	};
}