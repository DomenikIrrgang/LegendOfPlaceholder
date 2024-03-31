class_name DespawnUnitAction
extends CutsceneAction

@export
var unit_name: String = ""

func start() -> void:
	Globals.get_unit(unit_name).queue_free()
	cutscene_action_finished.emit(self)
