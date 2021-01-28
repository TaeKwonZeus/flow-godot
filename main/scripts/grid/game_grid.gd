class_name GameGrid
extends Node2D


signal leaks_displayed(number)

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
var leaks = 0
var blocks_list = BlocksList.new()


func _ready():
	load_from_json(GlobalLevelData.level_path)
	emit_signal("leaks_displayed", leaks)


func find_blocks_at_direction(pos, direction):
	var output = []
	var ray = pos
	var current = blocks_list.get_object_by_position(ray)
	
	while not current == null:
		output.append(current)
		ray += direction
		current = blocks_list.get_object_by_position(ray)
		
		if not current == null and not current is MoveableBlock:
			return null
	
	return output


func request_move(pos, direction):
	var _blocks_at_direction = find_blocks_at_direction(pos, direction)
	
	if _blocks_at_direction == null:
		return
	
	for block in blocks_list.object_list:
		var local_pos = blocks_list.get_position_by_object(block)
		if block in _blocks_at_direction:
			blocks_list.set_position(block, local_pos + direction)
		else:
			blocks_list.set_position(block, local_pos)


func export_to_json(level_name):
	var file_path = path + level_name + ".json"
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_line(to_json(_get_json_list()))
	file.close()


func _delete_children():
	for child in get_children():
		remove_child(child)
		child.queue_free()


func load_from_json(file_path):
	_delete_children()
	blocks_list.clear()
	
	var file = File.new()
	file.open(file_path, File.READ)
	var content = parse_json(file.get_as_text())
	
	for data in content:
		blocks_list.add_block(data)
		
		var obj_instance = TYPE_MATCH[data["type"]].instance()
		add_child(obj_instance)
		
		blocks_list.object_list.append(obj_instance)
		obj_instance.position = _list_to_vec(data["position"])
		obj_instance.rotation = deg2rad(data["rotation"])


func _get_json_list():
	var list = []
	
	for block in range(blocks_list.object_list.size()):
		list.append({
			"type": blocks_list._types_list[block],
			"position": _vec_to_list(blocks_list._positions_list[block][-1]),
			"rotation": round(rad2deg(blocks_list._rotations_list[block]))
		})
	
	return list


func _vec_to_list(vec):
	return [vec.x, vec.y]


func _list_to_vec(list):
	return Vector2(list[0], list[1])


func undo():
	pass
