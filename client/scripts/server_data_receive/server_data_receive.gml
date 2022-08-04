// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function server_data_receive(){
	var pSize = async_load[? "size"]
	if (pSize > 0){
		var type = async_load[? "type"] // what a type packet, not a json type inside
		var c_rec_buff = async_load[? "buffer"]

		buffer_seek(c_rec_buff,buffer_seek_start,0);
		var message_id=buffer_read(c_rec_buff, buffer_string) //buffer_text
		response = json_decode(message_id);
		show_debug_message(message_id)
				
		response_type = ds_map_find_value(response , "type");
		switch (response_type){
#region Buttons of login room
			//recive list of strver
			case msgType.UPDATE_SERVER_LIST:
				global.serverList = ds_map_find_value(response, "serverList");
				if (instance_exists(obj_button_join)){
					instance_destroy(obj_button_join)
				}
				for(i=0;i<ds_list_size(global.serverList);i++){
					var server = i
					server_number = instance_create_layer(10,10+ (i*64)+(i*10), "Server_Buttons",obj_button_join)
					with (server_number){
						server_name = server
					}
				}
			break
			
			// Used on button obj_button_join. 
			case msgType.JOIN_HOST:
				show_debug_message("< " + message_id);
				var joinedServer = ds_map_find_value(response, "joinedServer");
				
				//show_debug_message("we create host number " + string(hostNumber) + " and our player")
				if(joinedServer>=0){ //If -1 = 
					global.client_info.player_pId = ds_map_find_value(response, "pId");
					global.client_info.serverId = ds_map_find_value(response, "serverId");
					//room_goto(rmGameWorld)
				}else{show_message("Error")}
			break
			
#endregion
		}

	}
}
		
		
