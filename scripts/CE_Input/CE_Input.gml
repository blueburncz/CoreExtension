/// @function CE_Input()
/// @extends CE_Class
/// @desc Input-handling singleton.
function CE_Input()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var {ds_map<string/real, real[]>} Mapping of actions to an array
	/// of keys that trigger them.
	/// @private
	static ActionToKeys = ds_map_create();

	/// @var {ds_map<real, string/real>} Mapping of keys to action they trigger.
	/// @private
	static KeyToAction = ds_map_create();

	/// @func UnbindKey(_key)
	/// @desc Unbinds a key from an action.
	/// @param {real} _key The key to unbind.
	/// @return {CE_Input} Returns `self`.
	static UnbindKey = function (_key) {
		gml_pragma("forceinline");
		if (ds_map_exists(KeyToAction, _key))
		{
			var _action = KeyToAction[? _key];
			var _keys = ActionToKeys[? _action];
			var _index = 0;
			repeat (array_length(_keys))
			{
				if (_keys[_index] == _key)
				{
					array_delete(_keys, _index, 1);
					if (array_length(_keys) == 0)
					{
						ds_map_delete(ActionToKeys, _action);
					}
					break;
				}
				++_index;
			}
			ds_map_delete(KeyToAction, _key);
		}
		return self;
	};

	/// @func UnbindAction(_action)
	/// @desc Unbinds all keys from an action.
	/// @param {string/real} _action The action to unbind.
	/// @return {CE_Input} Returns `self`.
	static UnbindAction = function (_action) {
		gml_pragma("forceinline");
		if (ds_map_exists(ActionToKeys, _action))
		{
			var _keys = ActionToKeys[? _action];
			var _index = 0;
			repeat (array_length(_keys))
			{
				ds_map_delete(KeyToAction, _keys[_index++]);
			}
			ds_map_delete(ActionToKeys, _action);
		}
		return self;
	};

	/// @func Bind(_action, _key)
	/// @desc Binds a key to an action.
	/// @param {string/real} _action The action to bind the key to.
	/// @param {real} _key The key to bind to the action.
	/// @return {CE_Input} Returns `self`.
	/// @note If the key is already bound to an action, it is unbound first.
	static Bind = function (_action, _key) {
		gml_pragma("forceinline");
		UnbindKey(_key);
		if (!ds_map_exists(ActionToKeys, _action))
		{
			ActionToKeys[? _action] = [];
		}
		array_push(ActionToKeys[? _action], _key);
		return self;
	};

	/// @func Check(_action)
	/// @desc Checks if any key bound to an action is held down.
	/// @param {string/real} _action The action to check.
	/// @return {bool} Returns `true` if a key bound to an action is held down.
	static Check = function (_action) {
		gml_pragma("forceinline");
		if (!ds_map_exists(ActionToKeys, _action))
		{
			return false;
		}
		var _keys = ActionToKeys[? _action];
		var _index = 0;
		repeat (array_length(_keys))
		{
			var _key = _keys[_index++];
			switch (_key)
			{
			case mb_any:
			case mb_left:
			case mb_middle:
			case mb_right:
			case mb_side1:
			case mb_side2:
				if (mouse_check_button(_key))
				{
					return true;
				}
				break;

			default:
				if (keyboard_check(_key))
				{
					return true;
				}
				break;
			}
		}
		return false;
	};

	/// @func CheckPressed(_action)
	/// @desc Checks if any key bound to an action was pressed.
	/// @param {string/real} _action The action to check.
	/// @return {bool} Returns `true` if a key bound to an action was pressed.
	static CheckPressed = function (_action) {
		gml_pragma("forceinline");
		if (!ds_map_exists(ActionToKeys, _action))
		{
			return false;
		}
		var _keys = ActionToKeys[? _action];
		var _index = 0;
		repeat (array_length(_keys))
		{
			var _key = _keys[_index++];
			switch (_key)
			{
			case mb_any:
			case mb_left:
			case mb_middle:
			case mb_right:
			case mb_side1:
			case mb_side2:
				if (mouse_check_button_pressed(_key))
				{
					return true;
				}
				break;

			default:
				if (keyboard_check_pressed(_key))
				{
					return true;
				}
				break;
			}
		}
		return false;
	};

	/// @func CheckReleased(_action)
	/// @desc Checks if any key bound to an action was released.
	/// @param {string/real} _action The action to check.
	/// @return {bool} Returns `true` if a key bound to an action was released.
	static CheckReleased = function (_action) {
		gml_pragma("forceinline");
		if (!ds_map_exists(ActionToKeys, _action))
		{
			return false;
		}
		var _keys = ActionToKeys[? _action];
		var _index = 0;
		repeat (array_length(_keys))
		{
			var _key = _keys[_index++];
			switch (_key)
			{
			case mb_any:
			case mb_left:
			case mb_middle:
			case mb_right:
			case mb_side1:
			case mb_side2:
				if (mouse_check_button_released(_key))
				{
					return true;
				}
				break;

			default:
				if (keyboard_check_released(_key))
				{
					return true;
				}
				break;
			}
		}
		return false;
	};
}