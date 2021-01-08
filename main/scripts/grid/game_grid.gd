class_name GameGrid
extends Node2D


const TYPE_MATCH = {
	"Player": preload("res://nodes/Player.tscn"),
	"Reservoir": preload("res://nodes/Reservoir.tscn"),
	"Jar": preload("res://nodes/Jar.tscn"),
	"Brick": preload("res://nodes/Brick.tscn"),
	"Wall": preload("res://nodes/Wall.tscn"),
	"Straight": preload("res://nodes/pipes/Straight.tscn"),
	"Corner": preload("res://nodes/pipes/Corner.tscn"),
	"T": preload("res://nodes/pipes/T.tscn"),
	"X": preload("res://nodes/pipes/X.tscn"),
}

export var path = "res://levels/"
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
	var _blocks_at_direction = find_blocks_at_direction(pos, direction)
	
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


func _delete_children():
	for child in get_children():
		remove_child(child)
		child.queue_free()


func load_from_json():
	_delete_children()
	_blocks.clear()
	
	var file_path = path + level_name + ".json"
	var file = File.new()
	file.open(file_path, File.READ)
	var content = parse_json(file.get_as_text())
	
	for data in content:
		var pos = _list_to_vec(data["position"])
		var rot = deg2rad(data["rotation"])
		var type = data["type"]
		
		var obj_instance = TYPE_MATCH[type].instance()
		add_child(obj_instance)
		
		obj_instance.position = pos
		set_pos(obj_instance, pos)
		obj_instance.rotation = rot


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
	return [vec.x, vec.y]


func _list_to_vec(list):
	return Vector2(list[0], list[1])


func _undo():
	for block in _blocks.keys():
		if _blocks[block].size() > 1:
			_blocks[block].pop_back()
