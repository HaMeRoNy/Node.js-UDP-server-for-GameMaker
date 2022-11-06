/// @description Insert description here
// You can write your code in this editor
maxSpeed = 2;
xScale = 1;
xbScale = 1
legs_sprite_index =legs_run_south
body_sprite_index = body_idle_south

/// @func round_n(value, increment)
function round_n(_val, _inc) {
	return round(_val/_inc)*_inc;
}

updateSprite = function(_dir){
	if(_dir == NO_DIRECTION){
		image_speed = 0;
		image_index = 0;
		return;
	}
	
	image_speed = 0.3;
	xScale = 1;
	switch(round_n(_dir, 45) % 360) {
	  case WEST: xScale = -1; legs_sprite_index = legs_run_east; break; 
	  case SOUTH_WEST: xScale = -1; legs_sprite_index = legs_run_south_east; break;
	  case NORTH_WEST: xScale = -1; legs_sprite_index = legs_run_north_east; break;
	  case EAST: legs_sprite_index = legs_run_east; break; 
	  case SOUTH_EAST: legs_sprite_index = legs_run_south_east; break;
	  case NORTH_EAST: legs_sprite_index = legs_run_north_east; break;
	  case NORTH: legs_sprite_index = legs_run_north; break;
	  case SOUTH: legs_sprite_index = legs_run_south; break;
	}
}
