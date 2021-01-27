extends Control


export var levels_folder = "res://levels/"
export var extension = ".json"


func load_items():
	show()
	
	for i in range($ItemList.get_item_count()):
		$ItemList.remove_item(i)
	
	var dir = Directory.new()
	
	if dir.open(levels_folder) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while not file_name == "":
			if not dir.current_is_dir() and file_name.ends_with(extension):
				var display_name = file_name
				$ItemList.add_item(display_name.trim_suffix(extension))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_load(index):
	var file_name = $ItemList.get_item_text(index)
	GlobalLevelData.load_level(levels_folder + file_name + extension, LevelOpenMode.PLAY)
