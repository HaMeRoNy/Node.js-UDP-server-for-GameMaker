/// @description full fit
var _frame_width = window_frame_get_width();
var _frame_height = window_frame_get_height();
if (_frame_width > 0 && _frame_height > 0
	&& (camera_get_view_width(view_camera[0]) != _frame_width ||camera_get_view_height(view_camera[0]) != _frame_height)
) {
	room_width = _frame_width;
	room_height = _frame_height;
	window_frame_set_region(0, 0, _frame_width, _frame_height);
	//trace("changing region to", 0, 0, room_width, room_height);
}