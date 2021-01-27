class_name BlocksList


var object_list = []
var _positions_list = []
var _rotations_list = []
var _types_list = []


func add_block(data):
	_positions_list.append(data["position"])
	_rotations_list.append(data["rotation"])
	_types_list.append(data["type"])
	
	return data["type"]
