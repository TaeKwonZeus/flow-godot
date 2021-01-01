extends Node


func movement_input():
	var output = Vector2.ZERO
	
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		if !Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down"):
			output.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		if !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
			output.y += Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
			
	return output
