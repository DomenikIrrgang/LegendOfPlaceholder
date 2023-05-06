extends Zone

func _ready() -> void:
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaslimeStart.tres"))	
