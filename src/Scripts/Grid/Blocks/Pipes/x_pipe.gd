class_name XPipe
extends Pipe


func _get_outputs(input):
	var output = [
		Vector2.RIGHT * WORLD_MODIFIER,
		Vector2.LEFT * WORLD_MODIFIER,
		Vector2.UP * WORLD_MODIFIER,
		Vector2.DOWN * WORLD_MODIFIER,
	]
	
	output.erase(input)
	
	return output


func _is_rotated_properly(_input):
	return true
