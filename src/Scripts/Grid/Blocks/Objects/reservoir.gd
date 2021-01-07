class_name Reservoir
extends Block


func _init():
	type = "Reservoir"


func _process(_delta):
	if Input.is_action_just_pressed("reservoir_open"):
		activate()


func activate():
	var pos_below = grid.get_pos(self) + Vector2.DOWN * WORLD_MODIFIER
	var output = grid.find_block_at_position(pos_below)
	
	if output != null and output is Pipe:
		output.activate(grid.get_pos(self))
