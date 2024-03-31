class_name StartCutsceneInteraction
extends Interaction

@export
var cutscene: Cutscene

@export
var alias: String = "Talk"

func start() -> void:
	CutsceneManager.start_cutscene(cutscene)

func get_alias() -> String:
	return alias

func get_icon() -> Texture:
	return load("res://assets/ui/quest/talk.png")
