class_name Player
extends MoveableBlock


var _movement_buffer = []


func _init():
	type = "Player"


func _process(_delta):
	_movement_input_buffer()
	
	if !tween.is_active():
		_handle_movement()


func _handle_movement():
	var direction = _movement_input() * WORLD_MODIFIER
	
	if direction != Vector2.ZERO:
		grid.request_move(position, direction)


func _movement_input_buffer():
	if Input.is_action_just_pressed("move_right"):
		_movement_buffer.append(Vector2.RIGHT)
	if Input.is_action_just_pressed("move_left"):
		_movement_buffer.append(Vector2.LEFT)
	if Input.is_action_just_pressed("move_up"):
		_movement_buffer.append(Vector2.UP)
	if Input.is_action_just_pressed("move_down"):
		_movement_buffer.append(Vector2.DOWN)
	if Input.is_action_just_released("move_right"):
		_movement_buffer.erase(Vector2.RIGHT)
	if Input.is_action_just_released("move_left"):
		_movement_buffer.erase(Vector2.LEFT)
	if Input.is_action_just_released("move_up"):
		_movement_buffer.erase(Vector2.UP)
	if Input.is_action_just_released("move_down"):
		_movement_buffer.erase(Vector2.DOWN)


func _movement_input():
	if _movement_buffer.empty():
		return Vector2.ZERO
	
	return _movement_buffer[0]
