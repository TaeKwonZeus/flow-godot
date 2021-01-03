class_name Player
extends MoveableBlock


func _process(delta):
	if !tween.is_active():
		_handle_movement()


func _handle_movement():
	var direction = InputManager.movement_input() * SPEED_MODIFIER

	if direction != Vector2.ZERO:
		grid.request_move(global_position, direction)
