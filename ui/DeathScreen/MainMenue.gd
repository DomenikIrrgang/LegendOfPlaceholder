extends Button

func _on_pressed():
	Globals.get_tree().paused = false
	await Globals.get_tree().process_frame
	SaveFileManager.unload_game_state()
	Globals.get_tree().change_scene_to_file("res://MainMenue/MainMenue.tscn")
