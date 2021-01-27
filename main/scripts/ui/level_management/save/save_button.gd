extends Button


const SAVE_MENU = preload("res://nodes/ui/SaveMenu.tscn")
var save_menu_instance


func _pressed():
	save_menu_instance = SAVE_MENU.instance()
	get_parent().add_child(save_menu_instance)
	save_menu_instance.connect("saved", $"/root/Play/GameGrid", "export_to_json")
