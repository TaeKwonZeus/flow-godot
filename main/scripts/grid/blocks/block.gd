class_name Block
extends Node2D


var type
var is_pipe = false
const WORLD_MODIFIER = 32
onready var grid = get_parent()


func _ready():
	grid.blocks_list.set_position(self, position)
