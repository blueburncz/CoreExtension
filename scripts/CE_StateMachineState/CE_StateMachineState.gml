/// @func CE_StateMachineState(_name)
/// @extends CE_Class
/// @desc A state of a state machine.
/// @param {string} _name The name of the state.
/// @see CE_StateMachine
function CE_StateMachineState(_name)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {CE_StateMachine/undefined} The state machine to which this state
	/// belongs.
	/// @readonly
	StateMachine = undefined;

	/// @var {string} The name of the state.
	Name = _name;

	/// @var {func/undefined} A function executed when a state machines enters
	/// this state. Should take the state as the first argument.
	OnEnter = undefined;

	/// @var {func/undefined} A function executed while the state is active.
	/// Should take the state as the first argument and delta time as the second.
	OnUpdate = undefined;

	/// @var {func/undefined} A function executed when a state machine exists this
	/// state. Should take the state as the first argument.
	OnExit = undefined;

	/// @var {bool} If `true` then the state is currently active.
	/// @readonly
	IsActive = false;

	/// @var {uint}
	/// @private
	ActiveSince = 0;

	/// @func GetDuration()
	/// @desc Retrieves how long (in milliseconds) has the state been active for.
	/// @return {uint} Number of milliseconds for which has the state been active.
	static GetDuration = function () {
		gml_pragma("forceinline");
		return (current_time - ActiveSince);
	};
}