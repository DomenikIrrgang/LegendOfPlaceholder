class_name MoveUnitAction
extends CutsceneAction

@export
var unit_name: String

@export
var path: Array[Vector2]

@export
var relative_path: bool = true

var acutal_path: Array[Vector2]
var unit: Unit

func start() -> void:
	unit = Globals.get_unit(unit_name)
	acutal_path = path.duplicate()
	if relative_path:
		for i in acutal_path.size():
			acutal_path[i] = unit.global_position + acutal_path[i]
	unit.walk_to_position(acutal_path)

func update(delta: float) -> void:
	if unit.global_position == acutal_path[acutal_path.size() - 1]:
		cutscene_action_finished.emit(self)
