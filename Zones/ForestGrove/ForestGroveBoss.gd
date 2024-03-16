extends Zone

func _ready() -> void:
	super()
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaslimeStart.tres"))
