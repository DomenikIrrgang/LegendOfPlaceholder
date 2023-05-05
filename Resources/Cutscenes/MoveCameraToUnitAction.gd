class_name MoveCameraToUnitAction
extends CutsceneAction

@export
var unit_name: String

var unit: Unit

func start() -> void:
	unit = Globals.get_unit(unit_name)
	Globals.get_camera().global_position = unit.global_position

func update(delta: float) -> void:
	var directional_vector = Globals.get_camera().global_position - Globals.get_camera().get_screen_center_position()
	var distance_to_target = directional_vector.length() 
	if distance_to_target < 7.0:
		cutscene_action_finished.emit(self)
