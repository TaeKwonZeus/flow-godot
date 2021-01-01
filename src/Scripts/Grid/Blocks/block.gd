class_name Block
extends Node2D


const SPEED_MODIFIER = 32
export(float) var speed = 0.06
onready var grid = get_parent()
onready var tween = get_node("Tween")


func _ready():
	grid.blocks[self] = position


func _process(_delta):
	var target_position = grid.blocks[self]
	var threshold = 1
	
	if (target_position - position).length_squared() > pow(threshold, 2):
		animate(target_position)
	else:
		position = target_position
		tween.stop(Tween)


func animate(requested_position):
	tween.interpolate_property(self, "position",
			position, requested_position, speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
