class_name BlocksList


var object_list = []
var _positions_list = []
var _rotations_list = []
var _types_list = []


func add_block(data):
	_positions_list.append([_list_to_vec(data["position"])])
	_rotations_list.append(data["rotation"])
	_types_list.append(data["type"])
	
	return data["type"]


func set_position(object, position):
	var index = object_list.find(object)
	
	if index >= 0:
		_positions_list[index].append(position)


func get_position_by_object(object):
	var index = object_list.find(object)
	
	if index >= 0:
		return _positions_list[index][-1]
	return null


func get_object_by_position(position):
	var index = -1
	
	for pos in _positions_list:
		if pos[-1] == position:
			index = _positions_list.find(pos)
	
	if index >= 0:
		return object_list[index]
	return null


func _vec_to_list(vec):
	return [vec.x, vec.y]


func _list_to_vec(list):
	return Vector2(list[0], list[1])


func clear():
	object_list.clear()
	_positions_list.clear()
	_rotations_list.clear()
	_types_list.clear()
