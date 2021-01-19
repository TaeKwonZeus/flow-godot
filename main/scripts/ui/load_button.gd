extends Button


func _ready():
	connect("pressed", self, "hide")
