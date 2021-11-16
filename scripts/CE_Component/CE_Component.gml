/// @func CE_Component()
/// @extends CE_Class
/// @desc Base class for entity components.
/// @see CE_Entity
function CE_Component()
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	/// @var The owner of the component. Equals to `undefined` if the component
	/// has not been added to an entity yet.
	/// @readonly
	Owner = undefined;

	/// @var {bool} If `false` then the component is disabled and it should not
	/// do anything.
	Enabled = true;

	/// @func OnAdd()
	/// @desc A function executed when the component is added to an entity.
	/// @return {CE_Component} Returns `self`.
	static OnAdd = function () {
		return self;
	};

	/// @func OnRemove()
	/// @desc A function executed when the component is removed from an entity.
	/// @return {CE_Component} Returns `self`.
	static OnRemove = function () {
		return self;
	};

	/// @func OnUpdate()
	/// @return {CE_Component} Returns `self`.
	static OnUpdate = function () {
		return self;
	};

	/// @func OnDraw()
	/// @return {CE_Component} Returns `self`.
	static OnDraw = function () {
		return self;
	};

	/// @func OnDrawGUI()
	/// @return {CE_Component} Returns `self`.
	static OnDrawGUI = function () {
		return self;
	};
}