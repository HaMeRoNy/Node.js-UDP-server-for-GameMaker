/// @description Insert description here
// You can write your code in this editor
maxSpeed = 1.25;

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
	
	image_speed = 1;
	xScale = 1;
	switch(round_n(_dir, 45) % 360) {
	  case WEST: xScale = -1; sprite_index = character; break; 
	  case SOUTH_WEST: xScale = -1; sprite_index = character; break;
	  case NORTH_WEST: xScale = -1; sprite_index = character; break;
	  case EAST: sprite_index = character; break; 
	  case SOUTH_EAST: sprite_index = character; break;
	  case NORTH_EAST: sprite_index = character; break;
	  case NORTH: sprite_index = character; break;
	  case SOUTH: sprite_index = character; break;
	}
}
