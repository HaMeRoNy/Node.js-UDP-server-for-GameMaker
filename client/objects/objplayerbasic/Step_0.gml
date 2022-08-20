read_controls()
movement(dpad_dir, maxSpeed);



mouse_dir=point_direction(x,y,mouse_x,mouse_y)
show_debug_message(mouse_dir)
xbScale = 1;
if(mouse_dir>157.6 && mouse_dir<=202.5){body_sprite_index = body_walk_east; xbScale = -1; show_debug_message("YES!1")} //
if(mouse_dir>202.6 && mouse_dir<=247.5){body_sprite_index = body_walk_south_east; xbScale = -1; show_debug_message("YES!2")} //
if(mouse_dir>112.6 && mouse_dir<=157.5){ body_sprite_index = body_walk_north_east; xbScale = -1;show_debug_message("YES!3")} //
if(mouse_dir>22.6 && mouse_dir<=67.5){body_sprite_index = body_walk_north_east;show_debug_message("YES!4")}
		
if(mouse_dir>337.6 && mouse_dir<=380 ){body_sprite_index = body_walk_east;show_debug_message("YES!5")}
if(mouse_dir>0 && mouse_dir<=22.5){body_sprite_index = body_walk_east;show_debug_message("YES!51")}
	
if(mouse_dir>292.6 && mouse_dir<=337.5){ body_sprite_index = body_walk_south_east;show_debug_message("YES!6")} //
if(mouse_dir>67.6 && mouse_dir<=112.5){body_sprite_index = body_walk_north;show_debug_message("YES!7")}
if(mouse_dir>247.6 && mouse_dir<=292.5){body_sprite_index = body_walk_south;show_debug_message("YES!8")} //

updateSprite(dpad_dir);
depth = -y