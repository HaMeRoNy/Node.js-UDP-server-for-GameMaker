global.client = network_create_socket(network_socket_udp)

global.client_info = {
	player_name : noone,
	player_pId : noone,
	serverId  : noone,
};

// For reliable messages
global.pending_messages = []
global.received_messages = [] 
alarm[0] = room_speed;


// Client clock
global.client_clock = 0
global.decimal_collector = 0.0
global.latency_array = []
global.latency = 0
global.delta_latency = 0

alarm[1] = room_speed * 0.5

// World state variables
global.last_world_state = 0
global.world_state_buffer = []
global.interpolation_offset = 100

var data = ds_map_create()
ds_map_set(data, "method", "FetchServerTime")
ds_map_set(data, "clientTime", current_time)
send_map_reliable_udp("127.0.0.1", 9091, 1, data)
ds_map_destroy(data)