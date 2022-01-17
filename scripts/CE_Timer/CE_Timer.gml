/// @func CE_Timer()
function CE_Timer() constructor
{
	/// @var {struct[]}
	/// @private
	TimeoutArray = [];

	/// @func AddTimeout(_callback, _duration)
	/// @param {func} _callback A function to execute after the timeout.
	/// @param {uint} _duration Timeout duration in seconds.
	/// @return {CE_TimerTimeout} The added timeout.
	static AddTimeout = function (_callback, _duration) {
		gml_pragma("forceinline");
		var _timeout = new CE_TimerTimeout(_callback, _duration);
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