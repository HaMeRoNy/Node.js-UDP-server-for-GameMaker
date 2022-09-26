// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.received_messages = [] 

function server_data_receive(){
	var pSize = async_load[? "size"]
	if (pSize > 0){
		var type = async_load[? "type"] // what a type packet, not a json type inside
		var c_rec_buff = async_load[? "buffer"]

		buffer_seek(c_rec_buff,buffer_seek_start,0);
		var message_id=buffer_read(c_rec_buff, buffer_string) //buffer_text
		response = json_decode(message_id);
				
		response_type = ds_map_find_value(response , "type");
		switch (response_type){
#region Buttons of login room
			 
			case msgType.HEARTBEAT: //HEARTBEAT = 0
				// Copy value
				var heart_beat = ds_map_find_value(response, "count");
				
				// Send heartbeat back
				var data = ds_map_create()
				ds_map_set(data, "count", heart_beat)
				send_map_UDP("127.0.0.1" , 9091 ,1 ,data, response_type )
				ds_map_destroy(data)
			break
			
			case msgType.RELIABLE:
				// Extract data
				var msg = ds_map_find_value(response, "text")
				var msgId = ds_map_find_value(response, "id")
				
				// Makes sure we dont accept a message twice
				for (var i=0;i<array_length(global.received_messages);i++) {
					if (global.received_messages[i] == msgId){
						return
					}
				}
				
				// Make sure the array does not get too big
				if (array_length(global.received_messages) > 10){
					array_pop(global.received_messages)
				}
				
				// Remembers recent messages
				array_push(global.received_messages, msgId)
				
				// Resend id
				var data = ds_map_create()
				ds_map_set(data, "id", msgId)
				send_map_UDP("127.0.0.1", 9091, 1, data, msgType.ACK)
				ds_map_destroy(data)
			break
							
#endregion
		}

	}
}
		
		
