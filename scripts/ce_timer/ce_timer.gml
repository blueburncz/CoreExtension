/// @func CE_Timeout(_callback, _duration)
/// @param {func} _callback
/// @param {uint} _duration
function CE_Timeout(_callback, _duration) constructor
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
	/// @return {CE_Timeout} Return self.
	static Cancel = function () {
		gml_pragma("forceinline");
		Canceled = true;
		return self;
	};
}

/// @func CE_Timer()
function CE_Timer() constructor
{
	/// @var {struct[]}
	/// @private
	TimeoutArray = [];

	/// @func AddTimeout(_callback, _duration)
	/// @param {func} _callback A function to execute after the timeout.
	/// @param {uint} _duration Timeout duration in seconds.
	/// @return {CE_Timeout} The added timeout.
	static AddTimeout = function (_callback, _duration) {
		gml_pragma("forceinline");
		var _timeout = new CE_Timeout(_callback, _duration);
		array_push(TimeoutArray, _timeout);
		return _timeout;
	};

	/// @func Update()
	/// @return {CE_Timer} Returns self.
	static Update = function () {
		var i = 0;
		repeat (array_length(TimeoutArray))
		{
			var _timeout = TimeoutArray[i];
			if (_timeout.Canceled)
			{
				array_delete(TimeoutArray, i, 1);
			}
			else if (current_time >= _timeout.Start + _timeout.Duration)
			{
				_timeout.Callback();
				array_delete(TimeoutArray, i, 1);
			}
			else
			{
				++i;
			}
		}
		return self;
	};
}