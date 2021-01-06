class_name Reservoir
extends Block


func _init():
	type = "Reservoir"


func _ready():
	if Input.is_action_just_pressed("reservoir_open"):
		activate()


func activate():
	var pos_below = grid.blocks[self][0] + Vector2.DOWN * WORLD_MODIFIER
	var output = grid.find_block_at_position(pos_below)
	
	if output != null and output is Pipe:
		output.activate(grid.blocks[self][0])
