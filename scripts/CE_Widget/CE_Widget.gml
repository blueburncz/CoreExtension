function CE_RectTransformComponent()
	: CE_Component() constructor
{
	CE_CLASS_GENERATED_BODY;

	Position = new CE_Vec3();

	Anchor = new CE_Vec2();

	Width = 1.0;

	Height = 1.0;

	Pivot = new CE_Vec2();

	Rotation = 0.0;

	Scale = new CE_Vec2(1.0);

	static ToMatrix = function () {
		gml_pragma("forceinline");
		var _matrix = matrix_build(-Width * Pivot.X, -Height * Pivot.Y, 0, 0, 0, 0, 1, 1, 1);
		_matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, Rotation, 1, 1, 1));
		_matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, 0, Scale.X, Scale.Y, 1));
		_matrix = matrix_multiply(_matrix, matrix_build(Position.X, Position.Y, 0, 0, 0, 0, 1, 1, 1));
		return _matrix;
	};
}

function CE_Widget()
	: CE_Entity() constructor
{
	Transform = new CE_RectTransformComponent()

	AddComponent(Transform);

	static OnDrawGUI = function () {
		gml_pragma("forceinline");
		var _transform = Transform;
		matrix_set(matrix_world, _transform.ToMatrix());
		draw_sprite_stretched(CE_Spr1x1, 0, 0, 0, _transform.Width, _transform.Height);
		return self;
	};
}