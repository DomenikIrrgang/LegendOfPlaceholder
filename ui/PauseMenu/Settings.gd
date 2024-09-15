extends Button

func _ready():
	pressed.connect(on_pressed)
	
func on_pressed() -> void:
	var settings = Globals.get_scene_tree().get_first_node_in_group("Settings")
	settings.hidden.connect(on_settings_hidden)
	settings.visible = not settings.visible
	
func on_settings_hidden() -> void:
	grab_focus()
	var settings = Globals.get_scene_tree().get_first_node_in_group("Settings")
	settings.hidden.disconnect(on_settings_hidden)
