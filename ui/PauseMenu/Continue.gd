extends Button

func _ready() -> void:
	pressed.connect(on_pressed)
	
func on_pressed() -> void:
	Globals.get_user_interface().get_node("PauseMenu").visible = false
	Globals.get_tree().paused = false
	
