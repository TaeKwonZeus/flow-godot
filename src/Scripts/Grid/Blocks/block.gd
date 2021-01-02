class_name Block
extends Node2D


onready var grid = get_node("/root/Main/GameGrid")


func _ready():
	grid.blocks[self] = global_position
