class_name Player
extends Block


export(int) var movementRate = 2\


func _process(delta):
	var isActive = tween.is_active()
	print(isActive)
	
	if !isActive:
		_handle_movement()


func _handle_input():
	return Vector2(
		int(Input.is_action_pressed("move_right")) - 
		int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - 
		int(Input.is_action_pressed("move_up"))
	)


func _handle_movement():
	var direction = _handle_input() * SPEED_MODIFIER

	if direction != Vector2.ZERO:
		grid.request_move(position, direction)
