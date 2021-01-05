class_name CornerPipe
extends Pipe


func _get_holes():
	return [
		(Vector2.LEFT * WORLD_MODIFIER).rotated(rotation).round(),
		(Vector2.DOWN * WORLD_MODIFIER).rotated(rotation).round(),
	]
