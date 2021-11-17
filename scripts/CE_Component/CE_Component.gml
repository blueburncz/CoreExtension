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
	static OnAdd = function () {
	};

	/// @func OnRemove()
	/// @desc A function executed when the component is removed from an entity.
	static OnRemove = function () {
	};

	/// @func OnPreUpdate(_delta)
	/// @param {real} _delta
	static OnPreUpdate = function (_delta) {
	};

	/// @func OnUpdate(_delta)
	/// @param {real} _delta
	static OnUpdate = function (_delta) {
	};

	/// @func OnPostUpdate(_delta)
	/// @param {real} _delta
	static OnPostUpdate = function (_delta) {
	};

	/// @func OnDraw()
	static OnDraw = function () {
	};

	/// @func OnDrawGUI()
	static OnDrawGUI = function () {
	};
}