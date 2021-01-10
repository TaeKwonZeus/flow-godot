extends ItemList


export var extension = ".json"


func load_items(path):
	show()
	var dir = Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while not file_name == "":
			if not dir.current_is_dir() and file_name.ends_with(extension):
				var display_name = file_name
				add_item(display_name.trim_suffix(extension))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
