class_name Reservoir
extends Block


func _init():
	type = "Reservoir"


func _process(_delta):
	if Input.is_action_just_pressed("reservoir_open"):
		activate()


func activate():
	var pos = grid.blocks_list.get_position_by_object(self)
	grid.leaks = 0
	
	var pos_below = pos + Vector2.DOWN * WORLD_MODIFIER
	var output = grid.blocks_list.get_object_by_position(pos_below)
	
	if not output == null and output is Pipe:
		output.activate(pos)
