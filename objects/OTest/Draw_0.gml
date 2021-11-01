navgrid.Render();

var _color = draw_get_color();
draw_set_color(c_orange);

if (clickX != undefined && clickY != undefined)
{
	draw_circle(clickX, clickY, 8, true);
}

if (path.Found)
{
	path.Start();
	var _xprev = path.GetX();
	var _yprev = path.GetY();
	while (path.HasNext())
	{
		path.Next();
		var _x = path.GetX();
		var _y = path.GetY();
		show_debug_message([_x, _y]);
		if (!path.HasNext())
		{
			draw_arrow(_xprev, _yprev, _x, _y, 16);
		}
		else
		{
			draw_line_width(_xprev, _yprev, _x, _y, 4);
		}
		_xprev = _x;
		_yprev = _y;
	}
}

if (obstacleFromX != undefined
	&& obstacleFromY != undefined)
{
	draw_set_color(keyboard_check(vk_shift) ? c_green : c_maroon);
	draw_rectangle(obstacleFromX, obstacleFromY, mouse_x, mouse_y, false);
}

draw_set_color(_color);