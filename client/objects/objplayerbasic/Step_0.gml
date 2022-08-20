read_controls()
movement(dpad_dir, maxSpeed);



dir=point_direction(x,y,mouse_x,mouse_y)
show_debug_message(dir)
xScale = 1;
if(dir>157.6 && dir<=202.5){body_sprite_index = "east/"; xScale = -1; show_debug_message("YES!1")} //
if(dir>202.6 && dir<=247.5){body_sprite_index = "south_east/"; xScale = -1; show_debug_message("YES!2")} //
if(dir>112.6 && dir<=157.5){ body_sprite_index = "north_east/"; xScale = -1;show_debug_message("YES!3")} //
if(dir>22.6 && dir<=67.5){body_sprite_index = "north_east/";show_debug_message("YES!4")}
		
if(dir>337.6 && dir<=380 ){body_sprite_index = "south_east/";show_debug_message("YES!5")}
if(dir>0 && dir<=22.5){body_sprite_index = "east/";show_debug_message("YES!51")}
	
if(dir>292.6 && dir<=337.5){ body_sprite_index = "south_east/";show_debug_message("YES!6")} //
if(dir>67.6 && dir<=112.5){body_sprite_index = "north/";show_debug_message("YES!7")}
if(dir>247.6 && dir<=292.5){body_sprite_index = "body_idle_south";show_debug_message("YES!8")} //

updateSprite(dpad_dir);