class_name StartDialog
extends Interaction

@export
var dialog: Dialog

@export
var alias: String = "Talk"

func start() -> void:
	DialogManager.show_dialog(dialog)

func get_alias() -> String:
	return alias

func get_icon() -> Texture:
	return load("res://assets/ui/quest/talk.png")
