extends Label


var default_text = "Leaks: "


func _on_leaks_changed(number):
	text = default_text + str(number)
