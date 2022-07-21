function read_controls() {
	var _key = vk_left;
	left[PRESSED] = keyboard_check_pressed(_key);
	left[RELEASED] = keyboard_check_released(_key);
	left[HELD] = keyboard_check(_key);

	_key = vk_right;
	right[PRESSED] = keyboard_check_pressed(_key);
	right[RELEASED] = keyboard_check_released(_key);
	right[HELD] = keyboard_check(_key);

	_key = vk_up;
	up[PRESSED] = keyboard_check_pressed(_key);
	up[RELEASED] = keyboard_check_released(_key);
	up[HELD] = keyboard_check(_key);

	_key = vk_down;
	down[PRESSED] = keyboard_check_pressed(_key);
	down[RELEASED] = keyboard_check_released(_key);
	down[HELD] = keyboard_check(_key);
	
	var _h = right[HELD]-left[HELD];
	var _v = down[HELD]-up[HELD];
	if(point_distance(0,0,_h,_v) > 0){
		dpad_dir=point_direction(0,0,_h,_v);
		}
	else{
		dpad_dir=NO_DIRECTION;
	}
	
}