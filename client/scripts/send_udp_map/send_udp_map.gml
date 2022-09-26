
// NOTE : data map is not deleted here anymore due to it causing bugs.
//        maps should be deleted in the same script they are created.

function send_map_UDP(ip, port, size, map, type){
	var player_buffer = buffer_create(size,buffer_grow,size)
	ds_map_add(map, "type" , type)
	var dataJson = json_encode(map);
	buffer_seek(player_buffer,buffer_seek_start,0);
	buffer_write(player_buffer,buffer_text,dataJson);
	network_send_udp_raw(global.client,ip,port,player_buffer,buffer_tell(player_buffer));
}