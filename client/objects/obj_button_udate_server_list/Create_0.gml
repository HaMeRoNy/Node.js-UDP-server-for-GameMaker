
image_speed = 0
global.serverList = 0

function up_ser(){
	data = ds_map_create()
	ds_map_add(data,"serverList", 0)
	sand_map_UDP("127.0.0.1" , 8070 ,1 ,data, msgType.UPDATE_SERVER_LIST )
}