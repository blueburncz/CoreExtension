/// @macro {real} The number of the user event to be executed when a GUI
/// event is triggered.
#macro CE_EV_BIND_GUI 1

/// @enum Enumeration of possible background image styles.
enum CE_EGuiBackgroundStyle
{
	/// @member Draw background scaled.
	Scale,
	/// @member Draw background stretched.
	Stretch,
	/// @member Draw background nine sliced.
	NineSlice,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum Enumeration of widget alignment.
enum CE_EGuiAlign
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
enum CE_EGuiPosition
{
	/// @enum Parent's scroll is applied to widget's position (default).
	Scroll,
	/// @enum Widget ignores parent's scroll.
	Fixed,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum Enumeration of possible content styles.
enum CE_EGuiContentStyle
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

/// @enum GUI events.
enum CE_EGuiEvent
{
	/// @member An event triggered when a widget loses focus.
	Blur,
	/// @member An event triggered when control's value has changed.
	Change,
	/// @member An event triggered when a widget is clicked.
	Click,
	/// @member An event triggered when a widget is deactivated.
	Deactivate,
	/// @member An event triggered when a widget is dragged.
	Drag,
	/// @member An event triggered when user stop dragging the widget.
	DragEnd,
	/// @member An event triggered when user starts dragging the widget.
	DragStart,
	/// @member An event triggered when a widget receives focus.
	Focus,
	/// @member An event triggered within the focused widget when a keyboard
	/// key is pressed.
	KeyPress,
	/// @member Total number of members of this enum.
	SIZE
};

/// @enum GUI widget types.
enum CE_EGuiWidget
{
	/// @member A widget that contains another widgets.
	Container,
	/// @member A horizontal slider.
	HSlider,
	/// @member An input.
	Input,
	/// @member A widget that is the root of the widget tree.
	Root,
	/// @member A text widget.
	Text,
	/// @member A blank widget.
	Widget,
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