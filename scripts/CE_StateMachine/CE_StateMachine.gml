/// @func CE_StateMachine()
/// @extends CE_Class
/// @desc A state machine.
/// @see CE_StateMachineState
function CE_StateMachine()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	/// @var {CE_StateMachineState[]} An array of sates.
	/// @private
	StateArray = [];

	/// @var {bool} If `false` then the state machine has not yet entered its
	/// initial state.
	/// @readonly
	/// @see CE_StateMachine.Start
	Started = false;

	/// @var {bool} If `true` then the state machine has reached its final state.
	/// @readonly
	/// @see CE_StateMachine.Finish
	Finished = false;

	/// @var {CE_StateMachineState/undefined} The current state.
	/// @readonly
	State = undefined;

	/// @var {func/undefined} A function executed on the Start of the state of
	/// the state machine. It should take the state machine as the first argument.
	OnEnter = undefined;

	/// @var {func/undefined} A function executed in the Update method *before*
	/// the current state is updated. It should take the state machine as the
	/// first argument and delta time as the second argument.
	OnPreUpdate = undefined;

	/// @var {func/undefined} A function executed when the state changes.
	/// It should take the state machine as the first argument and its previous
	/// state as the second argument.
	OnStateChange = undefined;

	/// @var {func/undefined} A function executed in the Update method *after*
	/// the current state is updated. It should take the state machine as the
	/// first argument and delta time as the second argument.
	OnPostUpdate = undefined;

	/// @var {func/undefined} A function executed on the end of the state machine.
	/// It should take the state machine as the first argument.
	OnExit = undefined;

	/// @func Start()
	/// @desc Enters the initial state of the state machine.
	/// @return {CE_StateMachine} Returns `self`.
	static Start = function () {
		gml_pragma("forceinline");
		Started = true;
		Finished = false;
		if (OnEnter != undefined)
		{
			OnEnter(self);
		}
		return self;
	};

	/// @func Finish()
	/// @desc Enters the exit state of the state machine.
	/// @return {CE_StateMachine} Returns `self`.
	static Finish = function () {
		gml_pragma("forceinline");
		Finished = true;
		if (OnExit != undefined)
		{
			OnExit(self);
		}
		return self;
	};

	/// @func AddState(_state)
	/// @desc Adds a state to the state machine.
	/// @param {CE_StateMachineState} _state The state to add.
	/// @return {CE_StateMachine} Returns `self`.
	static AddState = function (_state) {
		gml_pragma("forceinline");
		_state.StateMachine = self;
		array_push(StateArray, _state);
		return self;
	};

	/// @func ChangeState(_state)
	/// @desc Changes the state of the state machine and executes
	/// {@link CE_StateMachine.OnStateChange}.
	/// @param {uint} _state The new state.
	/// @return {CE_StateMachine} Returns itself.
	/// @throws {string} If an invalid state is passed.
	static ChangeState = function (_state) {
		gml_pragma("forceinline");

		// Check if the state is valid
		if (_state.StateMachine != self)
		{
			throw "Invalid state \"" + string(_state.Name) + "\"!";
		}

		// Exit current state
		var _statePrev = State;

		if (_statePrev != undefined)
		{
			if (_statePrev.OnExit != undefined)
			{
				_statePrev.IsActive = false;
				_statePrev.OnExit(_statePrev);
			}
		}

		// Enter new state
		State = _state;
		State.IsActive = true;
		State.ActiveSince = current_time;

		if (State.OnEnter != undefined)
		{
			State.OnEnter(State);
		}

		// Trigger OnStateChange
		if (OnStateChange != undefined)
		{
			OnStateChange(self, _statePrev);
		}

		return self;
	};

	/// @func Update(_deltaTime)
	/// @desc Executes function for the current state of the state machine
	/// (if defined).
	/// @param {real} _deltaTime How much time has passed since the last frame
	/// (in microseconds).
	/// @return {CE_StateMachine} Returns `self`.
	/// @note This function does not do anything if the state machine has not
	/// started yet or if it has already reached its final state.
	/// @see CE_StateMachine.Start
	/// @see CE_StateMachine.Finish
	static Update = function (_deltaTime) {
		gml_pragma("forceinline");

		if (!Started || Finished)
		{
			return self;
		}

		if (OnPreUpdate != undefined)
		{
			OnPreUpdate(self, _deltaTime);
		}

		if (State != undefined && State.OnUpdate != undefined)
		{
			State.OnUpdate(State);
		}

		if (OnPostUpdate != undefined)
		{
			OnPostUpdate(self, _deltaTime);
		}

		return self;
	};

	static Destroy = function () {
		method(self, Super_Class.Destroy)();
		for (var i = array_length(StateArray) - 1; i >= 0; --i)
		{
			StateArray[i].Destroy();
		}
	};
}