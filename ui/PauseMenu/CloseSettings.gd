extends Button

func _ready():
	pressed.connect(on_pressed)
	
func on_pressed() -> void:
	var settings = Globals.get_scene_tree().get_first_node_in_group("Settings")
	settings.visible = false
