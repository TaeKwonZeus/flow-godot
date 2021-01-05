class_name MoveableBlock
extends Block


export(float) var speed = 20
onready var tween = get_node("Tween")


func _process(_delta):
	var target_position = grid.blocks[self][0]
	var threshold = 1
	
	if (target_position - global_position).length_squared() > pow(threshold, 2):
		animate(target_position)
	else:
		position = target_position
		tween.stop(Tween)


func animate(requested_position):
	tween.interpolate_property(self, "position",
			global_position, requested_position, 1 / speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

