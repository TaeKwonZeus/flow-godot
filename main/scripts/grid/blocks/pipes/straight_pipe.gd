class_name StraightPipe
extends Pipe


func _init():
	type = "Straight"


func _get_holes():
	return [
		(Vector2.RIGHT * WORLD_MODIFIER).rotated(rotation).round(),
		(Vector2.LEFT * WORLD_MODIFIER).rotated(rotation).round(),
	]
