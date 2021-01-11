class_name GameGrid
extends Node2D


signal load_requested(path)

const TYPE_MATCH = {
	"Player": preload("res://nodes/blocks/objects/Player.tscn"),
	"Reservoir": preload("res://nodes/blocks/objects/Reservoir.tscn"),
	"Jar": preload("res://nodes/blocks/objects/Jar.tscn"),
	"Brick": preload("res://nodes/blocks/objects/Brick.tscn"),
	"Wall": preload("res://nodes/blocks/objects/Wall.tscn"),
	"Straight": preload("res://nodes/blocks/pipes/Straight.tscn"),
	"Corner": preload("res://nodes/blocks/pipes/Corner.tscn"),
	"T": preload("res://nodes/blocks/pipes/T.tscn"),
	"X": preload("res://nodes/blocks/pipes/X.tscn"),
}

export var path = "res://levels/"
export var level_name = "level_1"
var leaks = 0
var _blocks = {}
onready var ui = get_parent().get_node("UI")


func find_block_at_position(pos):
	for block in _blocks:
		if get_pos(block) == pos:
			return block
	
	return null


func find_blocks_at_direction(pos, direction):
	var output = []
	var ray = pos
	var current = find_block_at_position(ray)
	
	while not current == null:
		output.append(current)
		ray += direction
		current = find_block_at_position(ray)
		
		if not current == null and not current is MoveableBlock:
			return null
	
	return output


func request_move(pos, direction):
	var _blocks_at_direction = find_blocks_at_direction(pos, direction)
	
	if _blocks_at_direction == null:
		return
	
	for block in _blocks:
		var local_pos = get_pos(block)
		if block in _blocks_at_direction:
			set_pos(block, local_pos + direction)
		else:
			set_pos(block, local_pos)


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
	emit_signal("load_requested", path)


func on_load_from_json(filename):
	var actual_path = path + filename + ".json"
	_delete_children()
	_blocks.clear()
	
	var file = File.new()
	file.open(actual_path, File.READ)
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
		
		_blocks[obj_instance] = [pos]


func get_pos(obj):
	if obj in _blocks:
		return _blocks[obj][-1]


func set_pos(obj, pos):
	if not obj in _blocks:
		_blocks[obj] = []
	_blocks[obj].append(pos)


func _get_json_list():
	var list = []
	
	for block in _blocks:
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


func undo():
	for block in _blocks.keys():
		if _blocks[block].size() > 1:
			_blocks[block].pop_back()
