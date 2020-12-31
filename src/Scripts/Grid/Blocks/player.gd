class_name Player
extends Block


func _process(_delta):
	var direction = _handle_input() * SPEED_MODIFIER


func _handle_input():
	return Vector2(
		int(Input.is_action_just_pressed("move_right")) - 
		int(Input.is_action_just_pressed("move_left")),
		int(Input.is_action_just_pressed("move_down")) - 
		int(Input.is_action_just_pressed("move_up"))
	)
