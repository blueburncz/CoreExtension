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

	/// @func OnRoomStart()
	/// @desc A function executed when the room starts.
	static OnRoomStart = function () {
	};

	/// @func OnCollisionEnter(_other)
	/// @desc A function executed once the entity starts colliding with other
	/// entity.
	/// @param _other The other entity.
	static OnCollisionEnter = function (_other) {
	};

	/// @func OnCollision(_other)
	/// @desc A function executed while the entity collides with other entity.
	/// @param _other The other entity.
	static OnCollision = function (_other) {
	};

	/// @func OnCollisionExit(_other)
	/// @desc A function executed once the entity is not colliding with other
	/// entity anymore.
	/// @param _other The other entity.
	static OnCollisionExit = function (_other) {
	};

	/// @func OnPreUpdate(_deltaTime)
	/// @param {CE_DeltaTime} _deltaTime
	static OnPreUpdate = function (_deltaTime) {
	};

	/// @func OnUpdate(_deltaTime)
	/// @param {CE_DeltaTime} _deltaTime
	static OnUpdate = function (_deltaTime) {
	};

	/// @func OnPostUpdate(_deltaTime)
	/// @param {CE_DeltaTime} _deltaTime
	static OnPostUpdate = function (_deltaTime) {
	};

	/// @func OnDraw()
	static OnDraw = function () {
	};

	/// @func OnDrawGUI()
	static OnDrawGUI = function () {
	};
}