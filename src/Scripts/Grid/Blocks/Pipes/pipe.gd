class_name Pipe
extends MoveableBlock


var outputs = []


func _init():
	is_pipe = true


func activate(pos):
	print("Activated from position:", pos)
	
	var relative_input = pos - position
	
	if (!_is_rotated_properly(relative_input)):
		print("Invalid rotation!")
		return
	
	outputs = _get_outputs(relative_input)
	
	for output in outputs:
		var global = position + output
		var block = grid.find_block_at_position(global)
		
		if block != null and block.is_pipe:
			block.activate(grid.blocks[self])
		elif block != null and block is Jar:
			print("Yay")
		elif block == null:
			grid.leaks += 1


func _get_outputs(_input):
	pass


func _is_rotated_properly(_input):
	pass
