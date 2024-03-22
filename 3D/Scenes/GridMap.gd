extends GridMap


func destroyblock(worldcoordinate):
	var map_coordinate = local_to_map(worldcoordinate)
	set_cell_item(map_coordinate, -1)


func placeblock(worldcoordinate, blockindex):
	var map_coordinate = local_to_map(worldcoordinate)
	set_cell_item(map_coordinate, blockindex)
