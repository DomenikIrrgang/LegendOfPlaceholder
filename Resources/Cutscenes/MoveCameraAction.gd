class_name MoveCameraAction
extends CutsceneAction

@export
var target_position: Vector2

func start() -> void:
	Globals.get_camera().position = target_position

func update(delta: float) -> void:
	var directional_vector = Globals.get_camera().position - Globals.get_camera().get_screen_center_position()
	var distance_to_target = directional_vector.length() 
	if distance_to_target < 7.0:
		cutscene_action_finished.emit(self)
