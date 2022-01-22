#macro CE_NAVGRID_OBSTACLE      0
#macro CE_NAVGRID_MASK_OBSTACLE (1 << CE_NAVGRID_OBSTACLE)

#macro CE_NAVGRID_W       1
#macro CE_NAVGRID_MASK_W  (1 << CE_NAVGRID_W)

#macro CE_NAVGRID_N       2
#macro CE_NAVGRID_MASK_N  (1 << CE_NAVGRID_N)

#macro CE_NAVGRID_S       3
#macro CE_NAVGRID_MASK_S  (1 << CE_NAVGRID_S)

#macro CE_NAVGRID_E       4
#macro CE_NAVGRID_MASK_E  (1 << CE_NAVGRID_E)

#macro CE_NAVGRID_MASK_NW (CE_NAVGRID_MASK_N | CE_NAVGRID_MASK_W)

#macro CE_NAVGRID_MASK_NE (CE_NAVGRID_MASK_N | CE_NAVGRID_MASK_E)

#macro CE_NAVGRID_MASK_SW (CE_NAVGRID_MASK_S | CE_NAVGRID_MASK_W)

#macro CE_NAVGRID_MASK_SE (CE_NAVGRID_MASK_S | CE_NAVGRID_MASK_E)

/// @func CE_NavGrid(_x, _y, _width, _height, _cellWidth, _cellHeight)
/// @extends CE_Class
/// @param {real} _x The X position of the top left corner.
/// @param {real} _y The Y position of the top left corner.
/// @param {real} _width The width of the navgrid.
/// @param {real} _height The height of the navgrid.
/// @param {real} _cellWidth The width of a single cell.
/// @param {real} _cellHeight The height of a single cell.
/// @see CE_NavGridPath
function CE_NavGrid(_x, _y, _width, _height, _cellWidth, _cellHeight)
	: CE_Class() constructor
{
	CE_CLASS_GENERATED_BODY;

	static Super_Class = {
		Destroy: Destroy,
	};

	// Check if the cell coordinates can be encoded into 32bit uint
	if (_width > $FFFF | _height > $FFFF)
	{
		show_error("Maximum size of a navigation grid is " + string($FFFF) + "x" + string($FFFF) + "!", true);
	}

	/// @var {real}
	/// @readonly
	X = _x;

	/// @var {real}
	/// @readonly
	Y = _y;

	/// @var {uint}
	/// @readonly
	Width = _width;

	/// @var {uint}
	/// @readonly
	Height = _height;

	/// @var {real}
	/// @readonly
	CellWidth = _cellWidth;

	/// @var {real}
	/// @readonly
	CellHeight = _cellHeight;

	/// @var {uint}
	/// @private
	Rows = ceil(Width / CellWidth);

	/// @var {uint}
	/// @private
	Cols = ceil(Height / CellHeight);

	/// @var {ds_grid<uint>}
	/// @private
	Grid = ds_grid_create(Rows, Cols);

	/// @var {vertex_format}
	/// @private
	static VFormat = undefined;

	if (VFormat == undefined)
	{
		vertex_format_begin();
		vertex_format_add_position_3d();
		VFormat = vertex_format_end();
	}

	/// @var {vertex_buffer}
	/// @private
	VBuffer = undefined;

	/// @var {ds_priority}
	/// @private
	PriorityQueue = ds_priority_create();

	/// @var {ds_map<uint, real>}
	/// @private
	CostSoFar = ds_map_create();

	/// @func WorldToLocalX(_x)
	/// @desc Convers world-space X coordinate to a coordinate in the navgrid.
	/// @param {real} _x The world-space coordinate.
	/// @return {uint} The X coordinate in the navgrid.
	/// @private
	static WorldToLocalX = function (_x) {
		gml_pragma("forceinline");
		return floor((_x - X) / CellWidth);
	};

	/// @func WorldToLocalY(_y)
	/// @desc Convers world-space Y coordinate to a coordinate in the navgrid.
	/// @param {real} _y The world-space coordinate.
	/// @return {uint} The Y coordinate in the navgrid.
	/// @private
	static WorldToLocalY = function (_y) {
		gml_pragma("forceinline");
		return floor((_y - Y) / CellHeight);
	};

	/// @func LocalToWorldX(_x)
	/// @param {uint} _x
	/// @return {real}
	/// @see LocalToWorldY
	/// @private
	static LocalToWorldX = function (_x) {
		gml_pragma("forceinline");
		return (X + ((_x + 0.5) * CellWidth));
	};

	/// @func LocalToWorldY(_y)
	/// @param {uint} _y
	/// @return {real}
	/// @see LocalToWorldX
	/// @private
	static LocalToWorldY = function (_y) {
		gml_pragma("forceinline");
		return (Y + ((_y + 0.5) * CellHeight));
	};

	/// @func EncodeLocal(_x, _y)
	/// @param {uint} _x
	/// @param {uint} _y
	/// @return {uint}
	/// @see CE_NavGrid.DecodeLocalX
	/// @see CE_NavGrid.DecodeLocalY
	/// @private
	static EncodeLocal = function (_x, _y) {
		gml_pragma("forceinline");
		return ((_x << 16) | _y);
	};

	/// @func DecodeLocalX(_encoded)
	/// @param {uint} _encoded
	/// @see CE_NavGrid.DecodeLocalY
	/// @see CE_NavGrid.EncodeLocal
	/// @private
	static DecodeLocalX = function (_encoded) {
		gml_pragma("forceinline");
		return ((_encoded >> 16) & $FFFF);
	};

	/// @func DecodeLocalY(_encoded)
	/// @param {uint} _encoded
	/// @see CE_NavGrid.DecodeLocalX
	/// @see CE_NavGrid.EncodeLocal
	/// @private
	static DecodeLocalY = function (_encoded) {
		gml_pragma("forceinline");
		return (_encoded & $FFFF);
	};

	/// @func Clear()
	/// @desc Clears the navgrid.
	/// @return {CE_NavGrid} Returns `self`.
	static Clear = function () {
		gml_pragma("forceinline");
		ds_grid_clear(Grid, 0
			| CE_NAVGRID_MASK_W
			| CE_NAVGRID_MASK_N
			| CE_NAVGRID_MASK_E
			| CE_NAVGRID_MASK_S);
		return self;
	};

	/// @func DiffToMask(_diffX, _diffY)
	/// @desc Converts position difference between two cells into a mask.
	/// @param {int} _diffX The difference on the X axis. Can be either -1, 0, or 1.
	/// @param {int} _diffY The difference on the Y axis. Can be either -1, 0, or 1.
	/// @return {int} One of the `CE_NAVGRID_*` constants or -1 on error.
	/// @private
	static DiffToMask = function (_diffX, _diffY) {
		gml_pragma("forceinline");
		switch (_diffX)
		{
		case -1:
			switch (_diffY)
			{
			case -1:
				return CE_NAVGRID_MASK_NW;
			case 0:
				return CE_NAVGRID_MASK_W;
			case 1:
				return CE_NAVGRID_MASK_SW;
			}
			break;

		case 0:
			switch (_diffY)
			{
			case -1:
				return CE_NAVGRID_MASK_N;
			case 1:
				return CE_NAVGRID_MASK_S;
			}
			break;

		case 1:
			switch (_diffY)
			{
			case -1:
				return CE_NAVGRID_MASK_NE;
			case 0:
				return CE_NAVGRID_MASK_E;
			case 1:
				return CE_NAVGRID_MASK_SE;
			}
			break;
		}
		return -1;
	};

	/// @func Disconnect(_aX, _aY, _bX, _bY)
	/// @func Disconnects two cells.
	/// @param {uint} _aX The X coordinate of the first cell.
	/// @param {uint} _aY The Y coordinate of the first cell.
	/// @param {uint} _bX The X coordinate of the second cell.
	/// @param {uint} _bY The Y coordinate of the second cell.
	/// @return {CE_NavGrid} Returns `self`.
	static Disconnect = function (_aX, _aY, _bX, _bY) {
		gml_pragma("forceinline");

		_aX = WorldToLocalX(_aX);
		_aY = WorldToLocalY(_aY);
		_bX = WorldToLocalX(_bX);
		_bY = WorldToLocalY(_bY);

		var _diffX = _bX - _aX;
		var _diffY = _bY - _aY;
		var _mask;

		if (abs(_diffX) > 1 || abs(_diffY) > 1)
		{
			show_error("Cells too far away!", true);
		}

		if (_diffX != 0 && _diffY != 0)
		{
			show_error("Cannot disconnect cells diagonally!", true);
		}

		// Disconnect A from B
		_mask = DiffToMask(_diffX, _diffY);

		if (_mask == -1)
		{
			show_error("Cannot disconnect given cells!", true);
		}

		if (_aX >= 0 && _aX < Rows
			&& _aY >= 0 && _aY < Cols)
		{
			Grid[# _aX, _aY] &= $FFFFFFFF & ~_mask;
		}

		// Disconnect B from A
		_mask = DiffToMask(-_diffX, -_diffY);

		if (_mask == -1)
		{
			show_error("Cannot disconnect given cells!", true);
		}
		
		if (_bX >= 0 && _bX < Rows
			&& _bY >= 0 && _bY < Cols)
		{
			Grid[# _bX, _bY] &= $FFFFFFFF & ~_mask;
		}

		return self;
	};

	/// @func AddObstacle(_x1, _y1, _x2, _y2)
	/// @func Marks cells within given rectangle as an obstacle.
	/// @param {uint} _x1 The X coordinate of the top left corner.
	/// @param {uint} _y1 The Y coordinate of the top left corner.
	/// @param {uint} _x2 The X coordinate of the bottom right corner.
	/// @param {uint} _y2 The Y coordinate of the bottom right corner.
	/// @return {CE_NavGrid} Returns `self`.
	static AddObstacle = function (_x1, _y1, _x2, _y2) {
		gml_pragma("forceinline");

		_x1 = floor((_x1 - X) / CellWidth);
		_y1 = floor((_y1 - Y) / CellHeight);
		_x2 = ceil((_x2 - X) / CellWidth);
		_y2 = ceil((_y2 - Y) / CellHeight);

		for (var i = _x1; i < _x2; ++i)
		{
			for (var j = _y1; j < _y2; ++j)
			{
				if (i < 0 || i >= Rows) continue;
				if (j < 0 || j >= Cols) continue;
				Grid[# i, j] |= CE_NAVGRID_MASK_OBSTACLE;
			}
		}

		return self;
	};

	/// @func RemoveObstacle(_x1, _y1, _x2, _y2)
	/// @func Removes obstacle mark within given rectangle.
	/// @param {uint} _x1 The X coordinate of the top left corner.
	/// @param {uint} _y1 The Y coordinate of the top left corner.
	/// @param {uint} _x2 The X coordinate of the bottom right corner.
	/// @param {uint} _y2 The Y coordinate of the bottom right corner.
	/// @return {CE_NavGrid} Returns `self`.
	static RemoveObstacle = function (_x1, _y1, _x2, _y2) {
		gml_pragma("forceinline");

		_x1 = floor((_x1 - X) / CellWidth);
		_y1 = floor((_y1 - Y) / CellHeight);
		_x2 = ceil((_x2 - X) / CellWidth);
		_y2 = ceil((_y2 - Y) / CellHeight);

		for (var i = _x1; i < _x2; ++i)
		{
			for (var j = _y1; j < _y2; ++j)
			{
				if (i < 0 || i >= Rows) continue;
				if (j < 0 || j >= Cols) continue;
				Grid[# i, j] &= ~CE_NAVGRID_MASK_OBSTACLE;
			}
		}

		return self;
	};

	static IsTraversableLocal = function (_fromX, _fromY, _toX, _toY, _allowDiagonal) {
		gml_pragma("forceinline");

		var _diffX = _toX - _fromX;
		var _diffY = _toY - _fromY;

		if (!_allowDiagonal
			&& _diffX != 0
			&& _diffY != 0)
		{
			return false;
		}

		var _grid = Grid;
		var _dataFrom = _grid[# _fromX, _fromY];
		var _dataTo = _grid[# _toX, _toY];

		// Check if there are obstacles
		if ((_dataFrom & CE_NAVGRID_MASK_OBSTACLE) > 0
			|| (_dataTo & CE_NAVGRID_MASK_OBSTACLE) > 0)
		{
			return false;
		}

		// Check if the cells are connected
		var _mask = DiffToMask(_diffX, _diffY);
		if (_mask == -1)
		{
			return false;
		}

		if ((_dataFrom & _mask) != _mask)
		{
			return false;
		}

		switch (_mask)
		{
		case CE_NAVGRID_MASK_NW:
			return ((_grid[# _fromX - 1, _fromY] & CE_NAVGRID_MASK_OBSTACLE) == 0
				|| (_grid[# _fromX, _fromY - 1] & CE_NAVGRID_MASK_OBSTACLE) == 0);

		case CE_NAVGRID_MASK_NE:
			return ((_grid[# _fromX + 1, _fromY] & CE_NAVGRID_MASK_OBSTACLE) == 0
				|| (_grid[# _fromX, _fromY - 1] & CE_NAVGRID_MASK_OBSTACLE) == 0);

		case CE_NAVGRID_MASK_SE:
			return ((_grid[# _fromX + 1, _fromY] & CE_NAVGRID_MASK_OBSTACLE) == 0
				|| (_grid[# _fromX, _fromY + 1] & CE_NAVGRID_MASK_OBSTACLE) == 0);

		case CE_NAVGRID_MASK_SW:
			return ((_grid[# _fromX - 1, _fromY] & CE_NAVGRID_MASK_OBSTACLE) == 0
				|| (_grid[# _fromX, _fromY + 1] & CE_NAVGRID_MASK_OBSTACLE) == 0);
		}

		return true;
	};

	/// @func IsTraversable(_fromX, _fromY, _toX, _toY, _allowDiagonal)
	/// @desc Checks whether the navgrid is traversable between two neighboring
	/// cells.
	/// @param {uint} _fromX The X coordinate of the first cell.
	/// @param {uint} _fromY The Y coordinate of the first cell.
	/// @param {uint} _toX The X coordinate of the second cell.
	/// @param {uint} _toY The Y coordinate of the second cell.
	/// @param {bool} _allowDiagonal Use `true` to allow diagonal traversal.
	/// @return {bool} Returns `true` if the cells are traversable.
	static IsTraversable = function (_fromX, _fromY, _toX, _toY, _allowDiagonal) {
		gml_pragma("forceinline");
		_fromX = WorldToLocalX(_fromX);
		_fromY = WorldToLocalY(_fromY);
		_toX = WorldToLocalX(_toX);
		_toY = WorldToLocalY(_toY);
		return IsTraversableLocal(_fromX, _fromY, _toX, _toY, _allowDiagonal);
	};

	/// @func FindPath(_path, _fromX, _fromY, _toX, _toY, _allowDiagonal)
	/// @desc Finds a path between two points.
	/// @param {CE_NavGridPath} _path The path to output the result to.
	/// @param {real} _fromX The X coordinate to find the path from.
	/// @param {real} _fromY The Y coordinate to find the path from.
	/// @param {real} _toX The X coordinate to find the path to.
	/// @param {real} _toY The Y coordinate to find the path to.
	/// @param {bool} _allowDiagonal Use `true` to allow diagonal traversal.
	/// @return {bool} Returns `true` if a path was found.
	/// @source https://www.redblobgames.com/pathfinding/a-star/introduction.html
	static FindPath = function (_path, _fromX, _fromY, _toX, _toY, _allowDiagonal) {
		gml_pragma("forceinline");

		_path.Clear();
		_path.NavGrid = self;
		_path.Found = false;
		_path.Diagonal = _allowDiagonal;
		_path.StartX = _fromX;
		_path.StartY = _fromY;
		_path.FinishX = _toX;
		_path.FinishY = _toY;

		var __toX = LocalToWorldX(WorldToLocalX(_toX));
		var __toY = LocalToWorldY(WorldToLocalY(_toY));

		_fromX = WorldToLocalX(_fromX);
		_fromY = WorldToLocalY(_fromY);
		_toX = WorldToLocalX(_toX);
		_toY = WorldToLocalY(_toY);

		if (_fromX < 0 || _fromY < 0 || _fromX >= Rows || _fromY >= Cols
			|| _toX < 0 || _toY < 0 || _toX >= Rows || _toY >= Cols)
		{
			return false;
		}

		_path.IndexStart = EncodeLocal(_fromX, _fromY);
		_path.IndexFinish = EncodeLocal(_toX, _toY);
		_path.IndexCurrent = _path.Start;

		if ((Grid[# _fromX, _fromY] & CE_NAVGRID_MASK_OBSTACLE) > 0
			|| (Grid[# _toX, _toY] & CE_NAVGRID_MASK_OBSTACLE) > 0)
		{
			return false;
		}

		// Swap start and destination points
		var _temp;
		_temp = _fromX;
		_fromX = _toX;
		_toX = _temp;

		_temp = _fromY;
		_fromY = _toY;
		_toY = _temp;

		var _from = EncodeLocal(_fromX, _fromY);
		var _to = EncodeLocal(_toX, _toY);
		var _found = false;

		var _priority = PriorityQueue;
		ds_priority_clear(_priority);
		ds_priority_add(_priority, _from, 0);

		var _costSoFar = CostSoFar;
		ds_map_clear(_costSoFar);
		_costSoFar[? _from] = 0;

		while (!ds_priority_empty(_priority))
		{
			var _current = ds_priority_delete_min(_priority);
			if (_current == _to)
			{
				_found = true;
				break;
			}

			var _currentX = DecodeLocalX(_current);
			var _currentY = DecodeLocalY(_current);

			if (_currentX < 0 || _currentX >= Rows) continue;
			if (_currentY < 0 || _currentY >= Cols) continue;

			var _cost;

			var i = 0;
			repeat (8)
			{
				var _nextX;
				var _nextY;

				switch (i++)
				{
				case 0:
					_nextX = _currentX - 1;
					_nextY = _currentY;
					_cost = 1;
					break;

				case 1:
					_nextX = _currentX - 1;
					_nextY = _currentY - 1;
					_cost = 2;
					break;

				case 2:
					_nextX = _currentX;
					_nextY = _currentY - 1;
					_cost = 1;
					break;

				case 3:
					_nextX = _currentX + 1;
					_nextY = _currentY - 1;
					_cost = 2;
					break;

				case 4:
					_nextX = _currentX + 1;
					_nextY = _currentY;
					_cost = 1;
					break;

				case 5:
					_nextX = _currentX + 1;
					_nextY = _currentY + 1;
					_cost = 2;
					break;

				case 6:
					_nextX = _currentX;
					_nextY = _currentY + 1;
					_cost = 1;
					break;

				case 7:
					_nextX = _currentX - 1;
					_nextY = _currentY + 1;
					_cost = 2;
					break;
				}

				if (_nextX < 0 || _nextX >= Rows) continue;
				if (_nextY < 0 || _nextY >= Cols) continue;

				if (!IsTraversableLocal(_currentX, _currentY, _nextX, _nextY, _allowDiagonal))
				{
					continue;
				}

				var _next = EncodeLocal(_nextX, _nextY);
				var _newCost = _costSoFar[? _current] + _cost; //Cost[# _nextX, _nextY];

				if (!ds_map_exists(_costSoFar, _next)
					|| _newCost < _costSoFar[? _next])
				{
					_costSoFar[? _next] = _newCost;
					var _heuristics = point_distance(
						LocalToWorldX(_nextX),
						LocalToWorldY(_nextY),
						__toX,
						__toY);
					ds_priority_add(_priority, _next, _newCost + _heuristics);
					_path.Add(_next, _current);
				}
			}
		}

		_path.Found = _found;

		return _found;
	};

	/// @func BuildMesh(_allowDiagonal)
	/// @desc Build a mesh from the navgrid.
	/// @param {bool} _allowDiagonal Use `true` to include diagonal lines.
	/// @return {CE_NavGrid} Returns `self`.
	/// @see CE_NavGrid.Render
	static BuildMesh = function (_allowDiagonal) {
		gml_pragma("forceinline");

		if (VBuffer != undefined)
		{
			vertex_delete_buffer(VBuffer);
		}
		VBuffer = vertex_create_buffer();
		var _vbuffer = VBuffer;

		vertex_begin(VBuffer, VFormat);
		for (var i = 0; i < Rows; ++i)
		{
			for (var j = 0; j < Cols; ++j)
			{
				var _x1 = X + (i * CellWidth);
				var _y1 = Y + (j * CellHeight);
				var _x2 = _x1 + CellWidth;
				var _y2 = _y1 + CellHeight;
				var _z = 0; //GetZ(_x1, _y1) + 1;
				var _data = Grid[# i, j];

				if (_data & CE_NAVGRID_MASK_OBSTACLE == 0)
				{
					vertex_position_3d(_vbuffer, _x1, _y1, _z); vertex_position_3d(_vbuffer, _x2, _y1, _z);
					vertex_position_3d(_vbuffer, _x2, _y1, _z); vertex_position_3d(_vbuffer, _x2, _y2, _z);
					vertex_position_3d(_vbuffer, _x2, _y2, _z); vertex_position_3d(_vbuffer, _x1, _y2, _z);
					vertex_position_3d(_vbuffer, _x1, _y2, _z); vertex_position_3d(_vbuffer, _x1, _y1, _z);
				}

				_x1 = (_x1 + _x2) * 0.5;
				_y1 = (_y1 + _y2) * 0.5;
				var _z1 = _z;

				if ((_data & CE_NAVGRID_MASK_OBSTACLE) > 0)
				{
					continue;
				}

				var r = 0;
				repeat (8)
				{
					var _x2;
					var _y2;
					var _i2;
					var _j2;

					switch (r++)
					{
					case 0:
						_x2 = _x1 - CellWidth;
						_y2 = _y1;
						_i2 = i - 1;
						_j2 = j;
						break;

					case 1:
						_x2 = _x1 - CellWidth;
						_y2 = _y1 - CellHeight;
						_i2 = i - 1;
						_j2 = j - 1;
						break;

					case 2:
						_x2 = _x1;
						_y2 = _y1 - CellHeight;
						_i2 = i;
						_j2 = j - 1;
						break;

					case 3:
						_x2 = _x1 + CellWidth;
						_y2 = _y1 - CellHeight;
						_i2 = i + 1;
						_j2 = j - 1;
						break;

					case 4:
						_x2 = _x1 + CellWidth;
						_y2 = _y1;
						_i2 = i + 1;
						_j2 = j;
						break;

					case 5:
						_x2 = _x1 + CellWidth;
						_y2 = _y1 + CellHeight;
						_i2 = i + 1;
						_j2 = j + 1;
						break;

					case 6:
						_x2 = _x1;
						_y2 = _y1 + CellHeight;
						_i2 = i;
						_j2 = j + 1;
						break;

					case 7:
						_x2 = _x1 - CellWidth;
						_y2 = _y1 + CellHeight;
						_i2 = i - 1;
						_j2 = j + 1;
						break;
					}

					//if (IsTraversableLocal(i, j, _i2, _j2, _allowDiagonal))
					//{
					//	var _z2 = 0; //GetZ(_x2, _y2) + 1;

					//	vertex_position_3d(_vbuffer, _x1, _y1, _z1);
					//	vertex_position_3d(_vbuffer, _x2, _y2, _z2);
					//}
				}
			}
		}
		vertex_end(VBuffer);
		vertex_freeze(VBuffer);
		return self;
	};

	/// @func Render()
	/// @desc Renders the navgrid's mesh.
	/// @return {CE_NavGrid} Returns `self`.
	/// @see CE_NavGrid.BuildMesh
	static Render = function () {
		if (VBuffer != undefined)
		{
			shader_set(CE_ShNavGrid);
			vertex_submit(VBuffer, pr_linelist, -1);
			shader_reset();
		}
		return self;
	};

	static Destroy = function () {
		method(self, Super_Class.Destroy)();
		ds_grid_destroy(Grid);
		ds_priority_destroy(PriorityQueue);
		ds_map_destroy(CostSoFar);
		if (VBuffer != undefined)
		{
			vertex_delete_buffer(VBuffer);
		}
	};

	Clear();
}