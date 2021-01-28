class_name MoveableBlock
extends Block


export(float) var speed = 20


func _process(_delta):
	var target_position = grid.blocks_list.get_position_by_object(self)
	var threshold = 1
	
	if (target_position - position).length_squared() > pow(threshold, 2):
		animate(target_position)
	else:
		position = target_position
		$Tween.stop(Tween)


func animate(requested_position):
	$Tween.interpolate_property(self, "position",
			position, requested_position, 1 / speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
