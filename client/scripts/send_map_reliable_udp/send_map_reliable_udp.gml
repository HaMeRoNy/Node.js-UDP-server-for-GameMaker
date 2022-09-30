// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_map_reliable_udp(ip, port, size, map){
	var data = ds_map_create()
	ds_map_copy(data, map)
	
	ds_map_add(data, "id", uuid_generate())
	send_map_UDP(ip, port, size, data, msgType.RELIABLE)
	
	var packet = ds_map_create()
	ds_map_add(packet, "ip", ip)
	ds_map_add(packet, "port", port)
	ds_map_add(packet, "data", data)
	
	array_push(global.pending_messages, packet)
}