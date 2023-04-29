extends Node2D

@onready
var mega_slime_one: MegaSlime = $MegaSlime

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	
func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
