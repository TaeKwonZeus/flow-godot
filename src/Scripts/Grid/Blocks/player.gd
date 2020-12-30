extends Block


func _process(delta):
	var input = _handle_input()
	position += input * SPEED_MODIFIER


func _handle_input():
	return Vector2(
		int(Input.is_action_just_pressed("move_right")) - 
		int(Input.is_action_just_pressed("move_left")),
		int(Input.is_action_just_pressed("move_down")) - 
		int(Input.is_action_just_pressed("move_up"))
	)
