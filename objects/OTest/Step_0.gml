timer.Update();

if (mouse_check_button_pressed(mb_left))
{
	clickX = mouse_x;
	clickY = mouse_y;
}

if (mouse_check_button_pressed(mb_right))
{
	obstacleFromX = mouse_x;
	obstacleFromY = mouse_y;
}

if (mouse_check_button_released(mb_right))
{
	if (obstacleFromX != undefined
		&& obstacleFromY != undefined)
	{
		if (keyboard_check(vk_shift))
		{
			navgrid.RemoveObstacle(
				min(obstacleFromX, mouse_x),
				min(obstacleFromY, mouse_y),
				max(obstacleFromX, mouse_x),
				max(obstacleFromY, mouse_y));
		}
		else
		{
			navgrid.AddObstacle(
				min(obstacleFromX, mouse_x),
				min(obstacleFromY, mouse_y),
				max(obstacleFromX, mouse_x),
				max(obstacleFromY, mouse_y));
		}
		navgrid.BuildMesh(false);
		obstacleFromX = undefined;
		obstacleFromY = undefined;
	}
}

if (keyboard_check_pressed(vk_backspace))
{
	navgrid.Clear();
	navgrid.BuildMesh(false);
}

if (clickX != undefined
	&& clickY != undefined)
{
	navgrid.FindPath(path, clickX, clickY, mouse_x, mouse_y, true);
}