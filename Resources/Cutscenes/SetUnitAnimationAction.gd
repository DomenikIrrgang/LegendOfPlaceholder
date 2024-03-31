class_name SetUnitAnimationAction
extends CutsceneAction

@export
var unit_name: String

@export
var animation_name: String

func start() -> void:
	var unit: Unit = Globals.get_unit(unit_name)
	unit.set_animation(animation_name)
	cutscene_action_finished.emit(self)
