extends Node


enum AxisTypes {
	HORIZONTAL,
	VERTICAL,
	NONE,
}
var _cur_axis = AxisTypes.NONE


func _process(delta):
	_movement_axis()


func _movement_axis():
	if (Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left")) and _cur_axis != AxisTypes.VERTICAL:
		_cur_axis = AxisTypes.HORIZONTAL
		
	if (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")) and _cur_axis != AxisTypes.HORIZONTAL:
		_cur_axis = AxisTypes.VERTICAL
		
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
		if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			_cur_axis = AxisTypes.VERTICAL
		else:
			_cur_axis = AxisTypes.NONE
			
	if Input.is_action_just_released("move_up") or Input.is_action_just_released("move_down"):
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			_cur_axis = AxisTypes.HORIZONTAL
		else:
			_cur_axis = AxisTypes.NONE


func movement_input():
	match _cur_axis:
		AxisTypes.HORIZONTAL:
			return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0)
		AxisTypes.VERTICAL:
			return Vector2(0, Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
		AxisTypes.NONE:
			return Vector2.ZERO
