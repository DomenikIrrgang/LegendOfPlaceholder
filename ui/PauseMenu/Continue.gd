extends Button

func _ready() -> void:
	pressed.connect(on_pressed)
	visibility_changed.connect(on_visiblity_changed)
	
func on_pressed() -> void:
	Globals.get_user_interface().get_node("PauseMenu").visible = false
	Globals.get_tree().paused = false
	
func on_visiblity_changed() -> void:
	if visible:
		grab_focus()
