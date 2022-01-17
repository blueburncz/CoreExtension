/// @enum Enumeration of possible background image styles.
enum CE_EGUIBackgroundStyle
{
	/// @member Draw background scaled.
	Scale,
	/// @member Draw background scaled, keeping the aspect ratio.
	Fit,
	/// @member Draw background stretched.
	Stretch,
	/// @member Draw background nine sliced.
	NineSlice,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum Enumeration of widget alignment.
enum CE_EGUIAlign
{
	/// @member Align at the start of the parent widget.
	Start = 0,
	/// @member Align at center of the parent widget.
	Center = 0.5,
	/// @member Align at the end of the parent widget.
	End = 1,
	/// @member Any value greater than 1 will act as 'fill'!
	Fill = 2,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum Enumeration of possible widget positions relative to their parent.
enum CE_EGUIPosition
{
	/// @enum Parent's scroll is applied to widget's position (default).
	Scroll,
	/// @enum Widget ignores parent's scroll.
	Fixed,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum Enumeration of possible content styles.
enum CE_EGUIContentStyle
{
	/// @enum Widgets are drawed in a column and their defined position becomes
	/// an offset from their calculated position.
	Column,
	/// @enum Widgets keep their defined position (default).
	Default,
	/// @enum Widgets are drawed in a grid and their defined position becomes
	/// an offset from the cell position.
	Grid,
	/// @enum Widgets are drawed in a rows and their defined position becomes
	/// an offset from their calculated position.
	Row,
	/// @member Total number of members of this enum.
	SIZE
};

/// @func ce_gui_mouse_in_rect(_x, _y, _width, _height)
/// @param {real} _x The x position of the rectangle's top left corner.
/// @param {real} _y The y position of the rectangle's top left corner.
/// @param {real} _width The width of the rectangle.
/// @param {real} _height The height of the rectangle.
/// @return {bool} True if the mouse is in the rectangle.
function ce_gui_mouse_in_rect(_x, _y, _width, _height)
{
	gml_pragma("forceinline");
	return ce_point_in_rect(
		global.__ceGuiCurrent.MouseX,
		global.__ceGuiCurrent.MouseY,
		_x,
		_y,
		_width,
		_height);
}