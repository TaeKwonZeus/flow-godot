class_name Block
extends Node2D


const SPEED_MODIFIER = 32
onready var grid = get_parent()


func _ready():
	print("Ready!")
	grid.blocks[self] = position
