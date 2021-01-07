class_name GameGrid
extends Node2D

export var path = "res://Levels/"
export var level_name = "level_1"
var leaks = 0
var blocks = {}
onready var player_tween = get_node("Player/Tween")


func _process(_delta):
	if Input.is_action_pressed("undo") and !player_tween.is_active():
		_undo()


func find_block_at_position(pos):
	for block in blocks.keys():
		if blocks[block][-1] == pos:
			return block
	
	return null


func find_blocks_at_direction(pos, direction):
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
	var blocks_at_direction = find_blocks_at_direction(pos, direction)
	
	if blocks_at_direction == null:
		return
	
	for block in blocks.keys():
		var local_pos = blocks[block][-1]
		if block in blocks_at_direction:
			blocks[block].append(local_pos + direction)
		else:
			blocks[block].append(local_pos)


func export_to_json():
	var file_path = path + level_name + ".json"
	var file = File.new()
	
	file.open(file_path, File.WRITE)
	file.store_line(to_json(_get_json_list()))
	file.close()


func get_pos(obj):
	if obj in blocks:
		return blocks[obj][-1]


func _get_json_list():
	var list = []
	
	for block in blocks.keys():
		list.append({
			"type": block.type,
			"position": _vec_to_list(blocks[block][-1]),
			"rotation": round(block.rotation_degrees)
		})
	
	return list


func _vec_to_list(vec):
	return [
		vec.x,
		vec.y,
	]


func _undo():
	for block in blocks.keys():
		if blocks[block].size() > 1:
			blocks[block].pop_back()
