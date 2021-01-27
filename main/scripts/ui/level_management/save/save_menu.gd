extends Control


signal saved(level_name)


func _on_saved():
	emit_signal("saved", $LineEdit.text)
	hide()
