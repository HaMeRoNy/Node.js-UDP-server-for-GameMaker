/// @description Resends messages
// You can write your code in this editor

for (var i=0;i<array_length(global.pending_messages);i++) {
	var ip = ds_map_find_value(global.pending_messages[i], "ip")
	var port = ds_map_find_value(global.pending_messages[i], "port")
	var data = ds_map_find_value(global.pending_messages[i], "data")
	show_debug_message(json_encode(global.pending_messages[i]))
	
	send_map_UDP(ip, port, 1, data, msgType.RELIABLE)
}

alarm[0] = room_speed * 1


