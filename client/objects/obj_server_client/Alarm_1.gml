alarm[1] = room_speed * 0.5

// Determine server latency
var data = ds_map_create()
ds_map_set(data, "method", "DetermineLatency")
ds_map_set(data, "clientTime", current_time)
send_map_reliable_udp("127.0.0.1", 9091, 1, data)
ds_map_destroy(data)

