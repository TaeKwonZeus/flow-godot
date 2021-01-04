extends Node


signal reservoir_opened

var _movement_buffer = []


func _process(_delta):
	_handle_movement_buffer()
	
	if Input.is_action_just_pressed("reservoir_open"):
		emit_signal("reservoir_opened")


func _handle_movement_buffer():
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


func movement_input():
	if _movement_buffer.empty():
		return Vector2.ZERO
	
	return _movement_buffer[0]
