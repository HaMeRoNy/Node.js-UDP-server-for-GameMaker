if (window_get_width() != w_width || window_get_height() != w_height || first_start) {
	first_start = false;
	show_debug_message("Resize dettected!!!!!!");
	
#region Adaptive resolution
		// (Local) Variable's
	w_width  = window_get_width();
	w_height = window_get_height();
	g_width  = display_get_gui_width();
	g_height = display_get_gui_height();
	s_width  = surface_get_width(application_surface);
	s_height = surface_get_height(application_surface);
	c_width  = camera_get_view_width(view_camera[0]);
	c_height = camera_get_view_height(view_camera[0]);
	w_width_mp  = w_width/ global._v_multply;
	w_height_mp = w_height/ global._v_multply;
	
	if(w_width != 0 || w_height != 0){
		surface_resize(application_surface, w_width, w_height);
		camera_set_view_size(view_camera[0], w_width_mp, w_height_mp);
	}
}

#endregion Adaptive resolution

if(check_v_multiplay != global._v_multply){
	check_v_multiplay = global._v_multply;
	
	show_debug_message("zoomed!");
	
	camera_set_view_size(view_camera[0], w_width_mp, w_height_mp);
	c_width  = camera_get_view_width(view_camera[0]);
	c_height = camera_get_view_height(view_camera[0]);
	camera_set_view_pos(view_camera[0], objPlayerBasic.x-c_width*0.5, objPlayerBasic.y-c_height*0.5);
	
}