extends Button

func _on_pressed():
	Globals.get_tree().paused = false
	Globals.get_player().respawn()
