/// @func CE_TweenBackIn(_time, _value, _final, _duration[, back])
/// @desc Cubic easing in with a back effect - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
/// @param {real} [_back] The intensity of the back effect.
function CE_TweenBackIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenBackOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenBackInOut(_time, _value, _final, _duration[, back])
/// @desc Cubic easing in with a back effect - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
/// @param {real} [_back] The intensity of the back effect.
function CE_TweenBackInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenBackOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenBackOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenBackOut(_time, _value, _final, _duration[, back])
/// @desc Cubic easing in with a back effect - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
/// @param {real} [_back] The intensity of the back effect.
function CE_TweenBackOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	var _back = (argument_count > 4) ? argument[4] : 1.75;
	_final -= _value;
	_time = (_time / _duration) - 1;
	return ((_final * ((_time * _time * ((_back + 1) * _time + _back)) + 1)) + _value);
}

/// @func CE_TweenBounceIn(_time, _value, _final, _duration)
/// @desc Easing in with bounces - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenBounceIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenBounceOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenBounceInOut(_time, _value, _final, _duration)
/// @desc Easing in/out with bounces - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenBounceInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenBounceOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenBounceOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenBounceOut(_time, _value, _final, _duration)
/// @desc Easing in/out with bounces - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenBounceOut(_time, _value, _final, _duration)
{
	_time /= _duration;
	_final -= _value;

	if (_time < 1 / 2.75)
	{
		return ((_final * 7.5625 * _time * _time) + _value);
	}

	if (_time < 2 / 2.75)
	{
		_time -= 1.5 / 2.75;
		return (_final * ((7.5625 * _time * _time) + 0.75) + _value);
	}

	if (_time < (2.5 / 2.75))
	{
		_time -= 2.25 / 2.75;
		return (_final * ((7.5625 * _time * _time) + 0.9375) + _value);
	}

	_time -= 2.625 / 2.75;
	return ((_final * ((7.5625 * _time * _time) + 0.984375)) + _value);
}

/// @func CE_TweenCircIn(_time, _value, _final, _duration)
/// @desc Circular easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCircIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenCircOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenCircInOut(_time, _value, _final, _duration)
/// @desc Circular easing in/out - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCircInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenCircOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenCircOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenCircOut(_time, _value, _final, _duration)
/// @desc Circular easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCircOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	_time /= _duration;
	--_time;
	return ((_final * sqr(1 - (_time * _time))) + _value);
}

/// @func CE_TweenCubicIn(_time, _value, _final, _duration)
/// @desc Cubic easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCubicIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenCubicOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenCubicInOut(_time, _value, _final, _duration)
/// @desc Cubic easing in/out - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCubicInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenCubicOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenCubicOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenCubicOut(_time, _value, _final, _duration)
/// @desc Cubic easing out - decelerating to zero velocity
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenCubicOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	_time /= _duration;
	--_time;
	return ((_final * ((_time * _time * _time) + 1)) + _value);
}

/// @func CE_TweenElasticIn(_time, _value, _final, _duration)
/// @desc Easing with an elastic effect - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenElasticIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenElasticOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenElasticInOut(_time, _value, _final, _duration)
/// @desc Easing in/out with an elastic effect - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenElasticInOut(_time, _value, _final, _duration)
{
	if (_time==0)
	{
		return _value;
	}

	_final -= _value;
	_time /= _duration * 0.5;

	if (_time == 2)
	{
		return (_value + _final);
	}

	var p = _duration * 0.3 * 1.5;
	var s = (_final < abs(_final))
		? (p / 4)
		: (p / (2 * pi)) * arcsin(1);

	_time -= 1;

	if (_time < 0)
	{
		return ((-0.5 * _final * power(2, 10 * _time) * sin(((_time * _duration) - s) * ((2 * pi) / p))) + _value);
	}

	return ((0.5 * _final * power(2, -10 * _time) * sin(((_time * _duration) - s) * ((2 * pi) / p))) + _final + _value);
}

/// @func CE_TweenElasticOut(_time, _value, _final, _duration)
/// @desc Easing out with an elastic effect - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenElasticOut(_time, _value, _final, _duration)
{
	if (_time == 0)
	{
		return _value;
	}

	_final -= _value;
	_time /= _duration;

	if (_time == 1)
	{
		return (_value + _final);
	}

	var p = _duration * 0.3;
	var s = (_final < 0)
		? (p / 4)
		: (p / (2 * pi)) * arcsin(1);

	return ((_final * power(2,-10 * _time) * sin(((_time * _duration) - s) * ((2 * pi) / p))) + _final + _value);
}

/// @func CE_TweenExpIn(_time, _value, _final, _duration)
/// @desc Exponential easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenExpIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenExpOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenExpInOut(_time, _value, _final, _duration)
/// @desc Exponential easing in/out - accelerating until halfway, then decelerating.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenExpInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenExpOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenExpOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenExpOut(_time, _value, _final, _duration)
/// @desc Exponential easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenExpOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	return ((_final * (-power(2, -10 * (_time / _duration)) + 1)) + _value);
}

/// @func CE_TweenLinear(_time, _value, _final, _duration)
/// @desc Simple linear tweening - no easing, no acceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenLinear(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	return ((_final * (_time / _duration)) + _value);
}

/// @func CE_TweenQuadIn(_time, _value, _final, _duration)
/// @desc Quadratic easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuadIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenQuadOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenQuadInOut(_time, _value, _final, _duration)
/// @desc Quadratic easing in/out - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuadInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenQuadOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenQuadOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenQuadOut(_time, _value, _final, _duration)
/// @desc Quadratic easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuadOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	_time /= _duration;
	return ((-_final * _time * (_time - 2)) + _value);
}

/// @func CE_TweenQuartIn(_time, _value, _final, _duration)
/// @desc Quartic easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuartIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenQuartOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenQuartInOut(_time, _value, _final, _duration)
/// @desc Quartic easing in/out - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuartInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenQuartOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenQuartOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenQuartOut(_time, _value, _final, _duration)
/// @desc Quartic easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuartOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	_time /= _duration;
	--_time;
	return ((-_final * (_time * _time * _time * _time - 1)) + _value);
}

/// @func CE_TweenQuintIn(_time, _value, _final, _duration)
/// @desc Quintic easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuintIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenQuintOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenQuintInOut(_time, _value, _final, _duration)
/// @desc Quintic easing in/out - acceleration until halfway, then deceleration.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuintInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenQuintOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenQuintOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenQuintOut(_time, _value, _final, _duration)
/// @desc Quintic easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenQuintOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	_time /= _duration;
	--_time;
	return ((_final * ((_time * _time * _time * _time * _time) + 1)) + _value);
}

/// @func CE_TweenSinIn(_time, _value, _final, _duration)
/// @desc Sinusoidal easing in - accelerating from zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenSinIn(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	return _value + _final - CE_TweenSinOut(_duration - _time, _value, _final, _duration);
}

/// @func CE_TweenSinInOut(_time, _value, _final, _duration)
/// @desc Sinusoidal easing in/out - accelerating until halfway, then decelerating.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenSinInOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	if (_time < _duration * 0.5)
	{
		return ((_value + _final - CE_TweenSinOut(_duration - _time * 2, _value, _final, _duration)) * 0.5) + (_value * 0.5);
	}
	return (CE_TweenSinOut(_time * 2 - _duration, _value, _final, _duration) * 0.5) + (_final * 0.5);
}

/// @func CE_TweenSinOut(_time, _value, _final, _duration)
/// @desc Sinusoidal easing out - decelerating to zero velocity.
/// @param {real} _time Current time in frames/seconds/µs...
/// @param {real} _value Starting value.
/// @param {real} _final Target value.
/// @param {real} _duration Duration in frames/seconds/µs...
function CE_TweenSinOut(_time, _value, _final, _duration)
{
	gml_pragma("forceinline");
	_final -= _value;
	return ((_final * sin((_time / _duration) * pi * 0.5)) + _value);
}