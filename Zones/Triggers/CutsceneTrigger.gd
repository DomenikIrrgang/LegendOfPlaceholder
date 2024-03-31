class_name CutsceneTrigger
extends Trigger

@export
var cutscene: Cutscene

func trigger() -> void:
	CutsceneManager.start_cutscene(cutscene)
