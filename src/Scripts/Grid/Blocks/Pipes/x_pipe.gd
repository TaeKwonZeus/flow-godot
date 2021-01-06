class_name XPipe
extends Pipe


func _init():
	type = "X"


func _get_holes():
	return [
		Vector2.UP * WORLD_MODIFIER,
		Vector2.DOWN * WORLD_MODIFIER,
		Vector2.LEFT * WORLD_MODIFIER,
		Vector2.RIGHT * WORLD_MODIFIER,
	]


func _is_rotated_properly(_input):
	return true
