extends Button

func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)
	
func on_visibility_changed() -> void:
	if visible:
		grab_focus()

func _on_pressed():
	Globals.get_tree().paused = false
	Globals.get_player().respawn()
