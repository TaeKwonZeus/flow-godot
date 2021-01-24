extends Node


var level_path
const PLAY_SCENE = "res://scenes/Play.tscn"


func load_level(path, mode):
	level_path = path
	
	match mode:
		LevelOpenMode.PLAY:
			get_tree().change_scene(PLAY_SCENE)
