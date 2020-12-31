class_name Player
extends Block


func _process(delta):
	._process(delta)
	
	var direction = _handle_input() * SPEED_MODIFIER
	if (direction != Vector2.ZERO):
		grid.request_move(position, direction)

	position = grid.blocks[self]


func _handle_input():
	return Vector2(
		int(Input.is_action_just_pressed("move_right")) - 
		int(Input.is_action_just_pressed("move_left")),
		int(Input.is_action_just_pressed("move_down")) - 
		int(Input.is_action_just_pressed("move_up"))
	)
