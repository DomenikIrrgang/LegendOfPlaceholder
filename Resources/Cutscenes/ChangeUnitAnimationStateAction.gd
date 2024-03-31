class_name ChangeUnitAnimationStateAction
extends CutsceneAction

@export
var unit_name: String

@export
var enabled: bool = true

func start() -> void:
	var unit: Unit = Globals.get_unit(unit_name)
	if enabled:
		unit.start_animation()
	else:
		unit.pause_animation()
	cutscene_action_finished.emit(self)
