class_name TPipe
extends Pipe


func _init():
	type = "T"


func _get_holes():
	return [
		(Vector2.LEFT * WORLD_MODIFIER).rotated(rotation).round(),
		(Vector2.RIGHT * WORLD_MODIFIER).rotated(rotation).round(),
		(Vector2.DOWN * WORLD_MODIFIER).rotated(rotation).round(),
	]
