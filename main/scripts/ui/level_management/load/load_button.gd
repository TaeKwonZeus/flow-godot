extends Button


const LOAD_MENU = preload("res://nodes/ui/LoadMenu.tscn")


func _pressed():
	var load_menu_instance = LOAD_MENU.instance()
	get_tree().get_root().add_child(load_menu_instance)
	load_menu_instance.load_items()
	
	hide()
