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
				
		response_type = ds_map_find_value(response , "type");
		switch (response_type){
			 
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
				var msgId = ds_map_find_value(response, "id")
				var msgMethod = ds_map_find_value(response, "method")
				
				// Makes sure we dont accept a message twice
				for (var i=0;i<array_length(global.received_messages);i++) {
					if (global.received_messages[i] == msgId){
						// Resend id 
						var data = ds_map_create()
						ds_map_set(data, "id", msgId)
						send_map_UDP("127.0.0.1", 9091, 1, data, msgType.ACK)
						ds_map_destroy(data)
						
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
				
				// Switch for different methods
				switch (msgMethod){
					case "FetchServerTime":
						// Set client clock, latency and id
						global.playerId = ds_map_find_value(response, "playerId")
						global.latency = (current_time - ds_map_find_value(response, "clientTime")) / 2
						global.client_clock = ds_map_find_value(response, "serverTime") + global.latency
					break;
					
					case "DetermineLatency":
						array_push(global.latency_array, (current_time - ds_map_find_value(response, "clientTime")) / 2)
			
						if (array_length(global.latency_array) == 9){
							var total_latency = 0
							array_sort(global.latency_array, true)
							var mid_point = global.latency_array[4]
							
							for (var i = array_length(global.latency_array)-1; i > -1; i--){
									if (global.latency_array[i] > (2 * mid_point) && global.latency_array[i] > 20){
										array_delete(global.latency_array, i, 1)
									}
									else {
										total_latency += global.latency_array[i]
									}
							}
							
							global.delta_latency = (total_latency / array_length(global.latency_array)) - global.latency
							global.latency = total_latency / array_length(global.latency_array)
							for (var i = 0; i < array_length(global.latency_array); i++){
								array_delete(global.latency_array, i, 1)
							}
							
							
							
						}
					break;
					
					case "playerDisconnect":
						// Make sure the client is not despawning itself
						if (ds_map_find_value(response, "playerId") != global.playerId){
							
							// Desapawn player
							var a = layer_get_all_elements("otherPlayers")
							for (var i = 0; i < array_length(a); i++;){
								if (layer_instance_get_instance(a[i]).ids ==  ds_map_find_value(response, "playerId")){
									instance_destroy(layer_instance_get_instance(a[i]))
								}
							}
						}
						
					
					break;
				}
				
			break
			
			case msgType.ACK:
				// Get the id 
				var msg_id = ds_map_find_value(response, "id")
				
				// Erases the map and array index
				for (var i = 0; i < array_length(global.pending_messages); i ++){
					if (msg_id == ds_map_find_value(ds_map_find_value(global.pending_messages[i], "data"), "id")){
						ds_map_destroy(ds_map_find_value(global.pending_messages[i], "data"))
						array_delete(global.pending_messages, i, 1)
					}
				}
			break
			
			case msgType.WORLDSTATE:
				// If newest world state, add to buffer
				if (ds_map_find_value(response, "time") > global.last_world_state){
					global.last_world_state = ds_map_find_value(response, "time")
					array_push(global.world_state_buffer, response)
				}
				
				
			break
							
		}

	}
}
		
		
