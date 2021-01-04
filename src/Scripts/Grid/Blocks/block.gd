class_name Block
extends Node2D


var is_pipe = false
const WORLD_MODIFIER = 32
onready var grid = get_node("/root/Main/GameGrid")


func _ready():
	grid.blocks[self] = global_position
