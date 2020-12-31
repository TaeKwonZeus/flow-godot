class_name Block
extends Node2D


const SPEED_MODIFIER = 32
export(float) var speed = 0.06
onready var grid = get_parent()
onready var tween = get_node("Tween")


func _ready():
	grid.blocks[self] = position


func _process(_delta):
	var targetPosition = grid.blocks[self]
	var threshold = 1
	
	if (targetPosition - position).length_squared() > pow(threshold, 2):
		animate(targetPosition)
	else:
		position = targetPosition
		tween.stop(Tween)


func animate(requestedPosition):
	tween.interpolate_property(self, "position",
		position, requestedPosition, speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
