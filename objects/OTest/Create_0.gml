timer = new CE_Timer();

// This one is canceled so it won't show
timer.AddTimeout(function () {
	show_debug_message("Timeout 1!");
}, 1000).Cancel();

timer.AddTimeout(function () {
	show_debug_message("Timeout 2!");
}, 1000);

var _cellSize = 32;
navgrid = new CE_NavGrid(10, 10, _cellSize * 40, _cellSize * 20, _cellSize, _cellSize);
navgrid.BuildMesh(false);
path = new CE_Path();

clickX = undefined;
clickY = undefined;

obstacleFromX = undefined;
obstacleFromY = undefined;