var _scale = lerp(0.8, 1.2, dsin(current_time * 0.5) * 0.5 + 0.5);
widget.Transform.Scale.X = _scale;
widget.Transform.Scale.Y = _scale;
widget.Transform.Rotation = current_time * 0.1;