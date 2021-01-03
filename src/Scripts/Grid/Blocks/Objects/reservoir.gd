class_name Reservoir
extends Block


func _ready():
	InputManager.connect("reservoir_opened", self, "activate")


func activate():
	var pos_below = grid.blocks[self] + Vector2.DOWN * WORLD_MODIFIER
	var output = grid.find_block_at_position(pos_below)
	
	if output != null and output is Pipe:
		output.activate(grid.blocks[self])
