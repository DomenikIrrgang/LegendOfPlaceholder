extends Node2D

@onready
var mega_slime_one: MegaSlime = $MegaSlime

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	#DialogManager.show_dialog(load("res://Resources/Dialogs/TestDialog.tres"), false)
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/TestCutscene.tres"))	
	
	
func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
