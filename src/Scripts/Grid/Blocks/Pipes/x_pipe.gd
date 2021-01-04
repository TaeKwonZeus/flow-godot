class_name XPipe
extends Pipe


func _get_outputs(input):
	return [
		-input,
		input.rotated(deg2rad(90)).round(),
		input.rotated(deg2rad(-90)).round(),
	]


func _is_rotated_properly(input):
	return true
