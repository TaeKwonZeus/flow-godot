class_name StraightPipe
extends Pipe


func _get_outputs(input):
	return [-input]


func _is_rotated_properly(input):
	var possible_outputs = [
		(Vector2.LEFT * WORLD_MODIFIER).rotated(rotation).round(), 
		(Vector2.RIGHT * WORLD_MODIFIER).rotated(rotation).round(),
	]
	
	print(global_rotation)
	print(possible_outputs, ", ", input)
	return possible_outputs.has(input)
