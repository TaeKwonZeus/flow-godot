class_name Pipe
extends MoveableBlock


var outputs = []


func _init():
	is_pipe = true


func activate(pos):
	var own_pos = grid.blocks[self]
	print("Activated from position:", pos)
	
	var relative_input = pos - own_pos
	
	if (!_is_rotated_properly(relative_input)):
		print("Invalid rotation!")
		return
	
	outputs = _get_outputs(relative_input)
	
	for output in outputs:
		var global = own_pos + output
		var block = grid.find_block_at_position(global)
		
		if block != null and block.is_pipe:
			block.activate(own_pos)
		elif block != null and block is Jar:
			print("Yay")
		elif block == null:
			print("Lol don't leak")
			grid.leaks += 1


func _get_outputs(input):
	var holes = _get_holes()
	holes.erase(input)
	return holes


func _get_holes():
	pass


func _is_rotated_properly(input):
	return _get_holes().has(input)
