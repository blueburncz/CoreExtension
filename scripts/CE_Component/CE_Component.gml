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