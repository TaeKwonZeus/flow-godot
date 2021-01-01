class_name Block
extends Node2D


onready var grid = get_parent()


func _ready():
	grid.blocks[self] = position
