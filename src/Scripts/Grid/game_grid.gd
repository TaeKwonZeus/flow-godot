class_name GameGrid
extends Node2D

export var path = "res://Levels/"
export var level_name = "level_1"
var leaks = 0
var _blocks = {}
onready var player_tween = get_node("Player/Tween")


func _process(_delta):
	if Input.is_action_pressed("undo") and !player_tween.is_active():
		_undo()


func find_block_at_position(pos):
	for block in _blocks.keys():
		if get_pos(block) == pos:
			return block
	
	return null


func find__blocks_at_direction(pos, direction):
	var output = []
	var ray = pos
	var current = find_block_at_position(ray)

	while current != null:
		output.append(current)
		ray += direction
		current = find_block_at_position(ray)
		
		if current != null and !current is MoveableBlock:
			return null

	return output


func request_move(pos, direction):
	var _blocks_at_direction = find__blocks_at_direction(pos, direction)
	
	if _blocks_at_direction == null:
		return
	
	for block in _blocks.keys():
		var local_pos = _blocks[block][-1]
		if block in _blocks_at_direction:
			_blocks[block].append(local_pos + direction)
		else:
			_blocks[block].append(local_pos)


func export_to_json():
	var file_path = path + level_name + ".json"
	var file = File.new()
	
	file.open(file_path, File.WRITE)
	file.store_line(to_json(_get_json_list()))
	file.close()


func get_pos(obj):
	if obj in _blocks:
		return _blocks[obj][-1]


func set_pos(obj, pos):
	if !_blocks.keys().has(obj):
		_blocks[obj] = []
	_blocks[obj].append(pos)


func _get_json_list():
	var list = []
	
	for block in _blocks.keys():
		list.append({
			"type": block.type,
			"position": _vec_to_list(_blocks[block][-1]),
			"rotation": round(block.rotation_degrees)
		})
	
	return list


func _vec_to_list(vec):
	return [
		vec.x,
		vec.y,
	]


func _undo():
	for block in _blocks.keys():
		if _blocks[block].size() > 1:
			_blocks[block].pop_back()
