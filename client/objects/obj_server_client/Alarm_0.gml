alarm[0] = room_speed

// Resend all messages
for (var i=0;i<array_length(global.pending_messages);i++){
	var ip = ds_map_find_value(global.pending_messages[i], "ip")
	var port = ds_map_find_value(global.pending_messages[i], "port")
	var data = ds_map_find_value(global.pending_messages[i], "data")
	
	send_map_UDP(ip, port, 1, data, msgType.RELIABLE)
}
