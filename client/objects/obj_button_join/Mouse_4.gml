/// @description Insert description here
// You can write your code in this editor

data = ds_map_create()
ds_map_add(data,"joinedServer", server_name)
sand_map_UDP("127.0.0.1" , 8070 ,1 ,data, msgType.HEARTBEAT )