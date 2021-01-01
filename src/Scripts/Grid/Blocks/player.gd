class_name Player
extends Block


func _process(delta):
	if !tween.is_active():
		_handle_movement()


func _handle_input():
	var vertical = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var horizontal
	
	if vertical == 0:
		horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	else:
		horizontal = 0
	
	return Vector2(horizontal, vertical)


func _handle_movement():
	var direction = _handle_input() * SPEED_MODIFIER

	if direction != Vector2.ZERO:
		grid.request_move(position, direction)
