global.client = network_create_socket(network_socket_udp)

global.client_info = {
	player_name : noone,
	player_pId : noone,
	serverId  : noone,
};

global.pending_messages = []
alarm[0] = room_speed;