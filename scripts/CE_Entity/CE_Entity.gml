/// @func CE_EntityInit()
/// @desc Makes an entity from a regular instance.
/// @example
/// ```gml
/// // Create event
/// CE_EntityInit();
/// transform = new CTransformComponent();
/// CE_EntityAddComponent(transform);
///
/// // Clean up event
/// CE_EntityDestroy();
/// ```
function CE_EntityInit()
{
	Components = ds_map_create();
}

/// @func CE_EntityAddComponent(_component)
/// @desc Adds a component to an entity.
/// @param {CE_Component} _component The component to add.
/// @return Returns `self`.
/// @throws {CE_Exception} If the component already has an owner.
function CE_EntityAddComponent(_component)
{
	gml_pragma("forceinline");
	if (_component.Owner != undefined)
	{
		throw new CE_Exception("Component already has an owner!");
	}
	_component.Owner = self;
	var _index = CE_ClassGetName(_component);
	if (!ds_map_exists(Components, _index))
	{
		Components[? _index] = [];
	}
	array_push(Components[? _index], _component);
	return self;
}

/// @func CE_EntityHasComponent(_component)
/// @desc Checks if entity has a component.
/// @param {CE_Component/typeof CE_Component} _component Either an instance
/// of a component or the component type.
/// @return {bool} Returns `true` if the entity has the component.
function CE_EntityHasComponent(_component)
{
	gml_pragma("forceinline");
	var _index = CE_ClassGetName(_component);
	if (!ds_map_exists(Components, _index))
	{
		return false;
	}
	if (!is_struct(_component))
	{
		return true;
	}
	var _components = Components[? _index];
	var i = 0;
	repeat (array_length(_components))
	{
		if (_components[i++] == _component)
		{
			return true;
		}
	}
	return false;
}

/// @func CE_EntityGetComponents(_component)
/// @desc Retrieves an array of component instances of given type.
/// @param {typeof CE_Component} _component The type of the component.
/// @return {CE_Component[]} An array of component instances.
function CE_EntityGetComponents(_component)
{
	gml_pragma("forceinline");
	var _index = CE_ClassGetName(_component);
	if (!ds_map_exists(Components, _index))
	{
		return [];
	}
	return Components[? _index];
}

/// @func CE_EntityRemoveComponent(_component)
/// @desc Removes a specific component or all instances of given component
/// type from an entity.
/// @param {CE_Component/typeof CE_Component} _component The component instance
/// or the type of the component to remove. If a type is passed, then all
/// component instances of given type are removed from the entity.
/// @return Returns `self`.
function CE_EntityRemoveComponent(_component)
{
	gml_pragma("forceinline");

	var _index = CE_ClassGetName(_component);
	var _components = Components[? _index];

	if (is_struct(_component))
	{
		var i = 0;
		repeat (array_length(_components))
		{
			var _instance = _components[i];
			if (_instance == _component)
			{
				_instance.Destroy();
				array_delete(_components, i, 1);
				break;
			}
			++i;
		}

		if (array_length(_components) == 0)
		{
			ds_map_delete(Components, _index);
		}
	}
	else
	{
		var i = 0;
		repeat (array_length(_components))
		{
			_components[i++].Destroy();
		}
		ds_map_delete(Components, _index);
	}

	return self;
}

/// @func CE_EntityDestroy()
/// @desc Frees resources used by an entity from memory.
function CE_EntityDestroy()
{
	gml_pragma("forceinline");
	ds_map_destroy(Components);
}

/// @func CE_Entity()
/// @extends CE_Class
/// @desc
/// @see CE_Component
function CE_Entity()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	/// @var {ds_map<string, CE_Component>} A map of entity's components.
	/// @private
	Components = ds_map_create();

	/// @func AddComponent(_component)
	/// @desc Adds a component instance to the entity.
	/// @param {CE_Component} _component The component to add.
	/// @return {CE_Entity} Returns `self`.
	/// @throws {CE_Exception} If the component already has an owner.
	static AddComponent = function (_component) {
		gml_pragma("forceinline");
		CE_EntityAddComponent(_component);
		return self;
	};

	/// @func HasComponent(_component)
	/// @desc Checks if the entity has a component.
	/// @param {CE_Component/typeof CE_Component} _component Either an instance
	/// of a component or the component type.
	/// @return {bool} Returns `true` if the entity has the component.
	static HasComponent = function (_component) {
		gml_pragma("forceinline");
		return CE_EntityHasComponent(_component);
	};

	/// @func GetComponents(_component)
	/// @desc Retrieves an array of component instances of given type.
	/// @param {typeof CE_Component} _component The type of the component.
	/// @return {CE_Component[]} An array of component instances.
	static GetComponents = function (_component) {
		gml_pragma("forceinline");
		return CE_EntityGetComponents(_component);
	};

	/// @func RemoveComponent(_component)
	/// @desc Removes a specific component or all instances of given component
	/// type from the entity.
	/// @param {CE_Component/typeof CE_Component} _component The component instance
	/// or the type of the component to remove. If a type is passed, then all
	/// component instances of given type are removed from the entity.
	/// @return {CE_Entity} Returns `self`.
	static RemoveComponent = function (_component) {
		gml_pragma("forceinline");
		CE_EntityRemoveComponent(_component);
		return self;
	};

	static OnDrawGUI = function () {
		return self;
	};

	static Destroy = function() {
		method(self, Super_Class.Destroy)();
		CE_EntityDestroy();
	};
}