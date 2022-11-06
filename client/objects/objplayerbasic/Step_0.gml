read_controls()
movement(dpad_dir, maxSpeed);



mouse_dir=point_direction(x,y,mouse_x,mouse_y)
xbScale = 1;
if(mouse_dir>157.6 && mouse_dir<=202.5){body_sprite_index = body_walk_east; xbScale = -1;} //
if(mouse_dir>202.6 && mouse_dir<=247.5){body_sprite_index = body_walk_south_east; xbScale = -1;} //
if(mouse_dir>112.6 && mouse_dir<=157.5){ body_sprite_index = body_walk_north_east; xbScale = -1;} //
if(mouse_dir>22.6 && mouse_dir<=67.5){body_sprite_index = body_walk_north_east;}
		
if(mouse_dir>337.6 && mouse_dir<=380 ){body_sprite_index = body_walk_east;}
if(mouse_dir>0 && mouse_dir<=22.5){body_sprite_index = body_walk_east;}
	
if(mouse_dir>292.6 && mouse_dir<=337.5){ body_sprite_index = body_walk_south_east;} //
if(mouse_dir>67.6 && mouse_dir<=112.5){body_sprite_index = body_walk_north;}
if(mouse_dir>247.6 && mouse_dir<=292.5){body_sprite_index = body_walk_south;} //

updateSprite(dpad_dir);
depth = -y
