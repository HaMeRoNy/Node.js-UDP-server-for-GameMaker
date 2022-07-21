///@func movement_and_collision(moveDir, moveSpeed, wallObj)
function movement(_mvDir, _mvSpd) {

	var _max_scan_angle = 75,
	    _inc = 1,
	    _limit  = 4;
	if(_mvDir < 0 || _mvDir >= 360 || _mvSpd == 0 ) return false;
 
	var _xTarg = x + lengthdir_x(_mvSpd, _mvDir),
	    _yTarg = y + lengthdir_y(_mvSpd, _mvDir);
 
	  x = _xTarg;
	  y = _yTarg;
	  return false;
}
