/// @description Camera
var _x = clamp(x - VIEW_W / 2, 0, room_width - VIEW_W),
    _y = clamp(y - VIEW_H / 2, 0, room_height - VIEW_H);

_x = lerp(VIEW_X, _x, .1);
_y = lerp(VIEW_Y, _y, .1);

camera_set_view_pos(VIEW, _x, _y);