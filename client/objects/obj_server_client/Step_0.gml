server_data_send()

// Send the player state
var data = ds_map_create()
ds_map_set(data, "time", global.client_clock)
ds_map_set(data, "x", objPlayerBasic.x)
ds_map_set(data, "y", objPlayerBasic.y)
send_map_UDP("127.0.0.1" , 9091 ,1 ,data, msgType.PLAYERSTATE )
ds_map_destroy(data)

// Update client clock each frame
global.client_clock += floor(delta_time / 1000) + global.delta_latency
global.delta_latency = 0

global.decimal_collector += (delta_time / 1000) - floor(delta_time / 1000)
if (global.decimal_collector >= 1.00){
	global.client_clock += 1
	global.decimal_collector -= 1.00
}

// Change the world states
var renderTime = global.client_clock - global.interpolation_offset
if (array_length(global.world_state_buffer) > 1){
	
	// Tidy up the buffer
	while((array_length(global.world_state_buffer) > 2 and renderTime > ds_map_find_value(global.world_state_buffer[2], "time")))
	{
		array_delete(global.world_state_buffer, 0, 1)
	}
	
	
	// If world state buffer is large enough interpolate
	if (array_length(global.world_state_buffer) > 2){
			var interpolationFactor = (renderTime - ds_map_find_value(global.world_state_buffer[1], "time")) / (ds_map_find_value(global.world_state_buffer[2], "time") - ds_map_find_value(global.world_state_buffer[1], "time"))
			
			// Loop through all players in world state
			for (var k = ds_map_find_first(global.world_state_buffer[2]); !is_undefined(k); k = ds_map_find_next(response, k)) {
					
				if (k == "type"){
					continue
				}
				
				if (k == "time"){
					continue
				}
				
				if (ds_map_exists(global.world_state_buffer[1], k) == false){
					continue
				}
				
				if (k == global.playerId){
					continue
				}
				
				var hasPlayer = false
				var a = layer_get_all_elements("otherPlayers")
				
				// Check if the player is already spawned
				for (var i = 0; i < array_length(a); i++;){
					if (layer_instance_get_instance(a[i]).ids == k){
						// If already sapwned change the x positions
						var ws1 = ds_map_find_value(global.world_state_buffer[1], k)
						var ws2 = ds_map_find_value(global.world_state_buffer[2], k)
						
						var newX = lerp(ds_map_find_value(ws1, "x"), ds_map_find_value(ws2, "x"), interpolationFactor)
						var newY = lerp(ds_map_find_value(ws1, "y"), ds_map_find_value(ws2, "y"), interpolationFactor)
						
						layer_instance_get_instance(a[i]).x = newX
						layer_instance_get_instance(a[i]).y = newY

						

						hasPlayer = true
						
						}
					}	
				
				// Spawn player
				if (hasPlayer == false){
					var ws2 = ds_map_find_value(global.world_state_buffer[2], k)
					var inst = instance_create_layer(ds_map_find_value(ws2, "x"), ds_map_find_value(ws2, "y"), "otherPlayers", objOtherPlayer)
					inst.ids = k
				}
			}
	}
	// If not enough world states extrapolate
	else if (renderTime > ds_map_find_value(global.world_state_buffer[1], "time")){
		var extrapolationFactor = (renderTime - ds_map_find_value(global.world_state_buffer[0], "time")) / (ds_map_find_value(global.world_state_buffer[1], "time") - ds_map_find_value(global.world_state_buffer[0], "time")) - 1.00
		for (var k = ds_map_find_first(global.world_state_buffer[1]); !is_undefined(k); k = ds_map_find_next(response, k)) {
			
				if (k == "type"){
					continue
				}
				
				if (k == "time"){
					continue
				}
				
				if (ds_map_exists(global.world_state_buffer[0], k) == false){
					continue
				}
				
				if (k == global.playerId){
					continue
				}
				
				var a = layer_get_all_elements("otherPlayers")
				for (var i = 0; i < array_length(a); i++;){
					if (layer_instance_get_instance(a[i]).ids == k){
						// If the player already exists extrapolate it
						var ws0 = ds_map_find_value(global.world_state_buffer[0], k)
						var ws1 = ds_map_find_value(global.world_state_buffer[1], k)
						
						
						var positionDeltaX = (ds_map_find_value(ws1, "x") - ds_map_find_value(ws0, "x"))
						var positionDeltaY = (ds_map_find_value(ws1, "y") - ds_map_find_value(ws0, "y"))
						
						var newPositionX = ds_map_find_value(ws1, "x") + (positionDeltaX * extrapolationFactor)
						var newPositionY = ds_map_find_value(ws1, "y") + (positionDeltaY * extrapolationFactor)
						
						layer_instance_get_instance(a[i]).x = newPositionX
						layer_instance_get_instance(a[i]).y = newPositionY

						
						}
					}	
		}
	}
	
}