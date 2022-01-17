/// @func CE_NavGridPath()
/// @see CE_NavGrid
function CE_NavGridPath() constructor
{
	/// @var {ds_map<uint, uint>}
	/// @private
	Map = ds_map_create();

	/// @var {bool} If `false` then the path was not found.
	/// @readonly
	Found = false;

	/// @var {CE_NavGrid/undefined} The navgrid to which the path belongs.
	/// @private
	NavGrid = undefined;

	/// @var {bool} If `true` then the path can possibly contain diagonal
	/// traversals.
	/// @readonly
	Diagonal = false;

	/// @var {uint}
	/// @private
	IndexStart = 0;

	/// @var {uint}
	/// @private
	IndexFinish = 0;

	/// @var {uint}
	/// @private
	IndexCurrent = undefined;

	/// @var {real}
	/// @readonly
	StartX = 0.0;

	/// @var {real}
	/// @readonly
	StartY = 0.0;

	/// @var {real}
	/// @readonly
	FinishX = 0.0;

	/// @var {real}
	/// @readonly
	FinishY = 0.0;

	/// @func Clear()
	/// @desc Clears the path data.
	/// @return {CE_NavGridPath} Returns `self`.
	static Clear = function () {
		gml_pragma("forceinline");
		ds_map_clear(Map);
		return self;
	};

	/// @func Add(_from, _to)
	/// @desc Defines traversal to the next cell.
	/// @param {uint} _from The cell we are traversing from (encoded).
	/// @param {uint} _to The cell we are traversing to (encoded).
	/// @return {CE_NavGridPath} Returns `self`.
	static Add = function (_from, _to) {
		gml_pragma("forceinline");
		Map[? _from] = _to;
		return self;
	};

	/// @func Start()
	/// @return {CE_NavGridPath} Returns `self`.
	static Start = function () {
		gml_pragma("forceinline");
		IndexCurrent = IndexStart;
		return self;
	};

	/// @func HasNext()
	/// @desc Checks if there is a next point in the path.
	/// @return {bool} Returns `true` if there is a next point in the path.
	static HasNext = function () {
		gml_pragma("forceinline");
		return ds_map_exists(Map, IndexCurrent);
	};

	/// @func Next()
	/// @desc Goes to the next point in the path.
	/// @return {CE_NavGridPath} Returns `self`.
	static Next = function () {
		gml_pragma("forceinline");
		IndexCurrent = Map[? IndexCurrent];
		return self;
	};

	/// @func GetX()
	/// @desc Retrieves the X coordinate of the current point.
	/// @return {real} The X coordinate of the current point.
	static GetX = function () {
		gml_pragma("forceinline");
		switch (IndexCurrent)
		{
		case IndexStart:
			return StartX;

		case IndexFinish:
			return FinishX;

		default:
			return NavGrid.LocalToWorldX(NavGrid.DecodeLocalX(IndexCurrent));
		}
	};

	/// @func GetY()
	/// @desc Retrieves the Y coordinate of the current point.
	/// @return {real} The Y coordinate of the current point.
	static GetY = function () {
		gml_pragma("forceinline");
		switch (IndexCurrent)
		{
		case IndexStart:
			return StartY;

		case IndexFinish:
			return FinishY;

		default:
			return NavGrid.LocalToWorldY(NavGrid.DecodeLocalY(IndexCurrent));
		}
	};

	/// @func Destroy()
	/// @desc Frees resources used by the navgrid from memory.
	static Destroy = function () {
		gml_pragma("forceinline");
		ds_map_destroy(Map);
	};
}