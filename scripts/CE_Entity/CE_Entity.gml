/// @func CE_EntityInit(_instance)
/// @desc Makes an entity from a regular instance.
/// @param _instance The instance to make an entity from.
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
/// @see CE_Entity
function CE_EntityInit(_instance)
{
	with (_instance)
	{
		Components = [];
	}
}

/// @func CE_EntityAddComponent(_entity, _component)
/// @desc Adds a component to an entity.
/// @param _entity The entity to add the component to.
/// @param {CE_Component} _component The component to add.
/// @return Returns `self`.
/// @throws {CE_Exception} If the component already has an owner.
function CE_EntityAddComponent(_entity, _component)
{
	gml_pragma("forceinline");
	with (_entity)
	{
		if (_component.Owner != undefined)
		{
			throw new CE_Exception("Component already has an owner!");
		}
		_component.Owner = self;
		array_push(Components, _component);
		return self;
	}
}

/// @func CE_EntityHasComponent(_entity, _component)
/// @desc Checks if entity has a component.
/// @param _entity The entity to check.
/// @param {CE_Component/typeof CE_Component} _component Either an instance
/// of a component or the component type.
/// @return {bool} Returns `true` if the entity has the component.
function CE_EntityHasComponent(_entity, _component)
{
	gml_pragma("forceinline");
	with (_entity)
	{
		var i = 0;
		repeat (array_length(Components))
		{
			var _current = Components[i++];

			// Looking for a specific instance
			if (is_struct(_component))
			{
				if (_current == _component)
				{
					return true;
				}
				continue;
			}

			// Looking for type
			if (_current.IsInstance(_component))
			{
				return true;
			}
		}
		return false;
	}
}

/// @func CE_EntityGetComponents(_entity[, _component])
/// @desc Retrieves an array of component instances of given type.
/// @param _entity The target entity.
/// @param {typeof CE_Component} [_component] The type of the component. If not
/// defined, then all components are returned.
/// @return {CE_Component[]} An array of component instances.
function CE_EntityGetComponents(_entity, _component=undefined)
{
	gml_pragma("forceinline");
	with (_entity)
	{
		// Return all components
		if (_component == undefined)
		{
			return Components;
		}

		// Filter components by type
		var _components = [];
		var i = 0;
		repeat (array_length(Components))
		{
			var _current = Components[i++];
			if (_current.IsInstance(_component))
			{
				array_push(_components, _current);
			}
		}
		return _components;
	}
}

/// @func CE_EntityRemoveComponent(_entity, _component)
/// @desc Removes a specific component or all instances of given component
/// type from an entity.
/// @param _entity The entity to remove the component from.
/// @param {CE_Component/typeof CE_Component} _component The component instance
/// or the type of the component to remove. If a type is passed, then all
/// component instances of given type are removed from the entity.
/// @return Returns `self`.
function CE_EntityRemoveComponent(_entity, _component)
{
	gml_pragma("forceinline");

	with (_entity)
	{
		if (is_struct(_component))
		{
			// Remove instance
			var i = 0;
			repeat (array_length(Components))
			{
				if (Components[i] == _component)
				{
					array_delete(Components, i, 1);
					break;
				}
				++i;
			}
		}
		else
		{
			// Remove by type
			var i = 0;
			repeat (array_length(Components))
			{
				if (Components[i].IsInstance(_component))
				{
					array_delete(Components, i, 1);
					break;
				}
			}
		}

		return self;
	}
}

/// @func CE_EntityCleanUp(_entity)
/// @desc Frees resources used by an entity from memory.
/// @param _entity The target entity.
function CE_EntityCleanUp(_entity)
{
	gml_pragma("forceinline");
	with (_entity)
	{
		var i = 0;
		repeat (array_length(Components))
		{
			Components[i++].Destroy();
		}
		Components = undefined;
	}
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

	/// @var {CE_Component[]} An array of all entity's components.
	/// @private
	Components = [];

	/// @var {ds_map<string, CE_Component>} Mapping of component types to component instances.
	/// @private
	ComponentIndex = ds_map_create();

	/// @func AddComponent(_component)
	/// @desc Adds a component instance to the entity.
	/// @param {CE_Component} _component The component to add.
	/// @return {CE_Entity} Returns `self`.
	/// @throws {CE_Exception} If the component already has an owner.
	static AddComponent = function (_component) {
		gml_pragma("forceinline");
		CE_EntityAddComponent(self, _component);
		return self;
	};

	/// @func HasComponent(_component)
	/// @desc Checks if the entity has a component.
	/// @param {CE_Component/typeof CE_Component} _component Either an instance
	/// of a component or the component type.
	/// @return {bool} Returns `true` if the entity has the component.
	static HasComponent = function (_component) {
		gml_pragma("forceinline");
		return CE_EntityHasComponent(self, _component);
	};

	/// @func GetComponents(_component)
	/// @desc Retrieves an array of component instances of given type.
	/// @param {typeof CE_Component} [_component] The type of the component.
	/// If not defined, then all components are returned.
	/// @return {CE_Component[]} An array of component instances.
	static GetComponents = function (_component=undefined) {
		gml_pragma("forceinline");
		return CE_EntityGetComponents(self, _component);
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
		CE_EntityRemoveComponent(self, _component);
		return self;
	};

	static Destroy = function() {
		method(self, Super_Class.Destroy)();
		CE_EntityCleanUp(self);
	};
}

/// @macro Shorthand used to call a method for each component of an entity.
/// @example
/// ```gml
/// // Step event
/// CE_EACH_COMPONENT.OnUpdate();
///
/// // Draw event
/// CE_EACH_COMPONENT.OnDraw();
/// ```
#macro CE_EACH_COMPONENT \
	var __ceComponents = CE_EntityGetComponents(self); \
	var __ceComponentsIndex = 0; \
	repeat (array_length(__ceComponents)) \
		__ceComponents[__ceComponentsIndex++]