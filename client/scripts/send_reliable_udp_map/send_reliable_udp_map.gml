/* 
	1. Send message
	2. Add message to pending_messages (should include ip, port, data)
	3. Resend messages if neccesary 
	4. Remove messages after ACK (will only include ID)
	
	question : what is the size variable used for when hes back
*/

function send_map_reliable_UDP(ip, port, size, map){
	ds_map_add(map, "id", uuid_generate())
	send_map_UDP(ip, port, size, map, msgType.RELIABLE)
	
	// Create map for array
	var pending_data = ds_map_create()
	
	ds_map_add(pending_data, "ip", ip)
	ds_map_add(pending_data, "port", port)
	ds_map_add_map(pending_data, "data", map)

	
	array_push(global.pending_messages, pending_data)

}