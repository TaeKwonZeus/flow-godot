class_name Block
extends Node2D


const SPEED_MODIFIER = 32
onready var grid = get_parent()


func _ready():
	grid.blocks[self] = position


func _process(_delta):
	position = grid.blocks[self]
