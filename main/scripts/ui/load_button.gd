extends Button


onready var loader = $"../Loader"


func _pressed():
	loader.load_items()
	hide()
