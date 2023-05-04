class_name ControlledMovementStrategy
extends UnitMovementStrategy

func _init(_unit: Unit):
	super(_unit)
	
func calculateMovementVelocity() -> Vector2:
	if not DialogManager.has_active_dialog() and not CutsceneManager.has_active_cutscene() and not SceneSwitcher.is_loading_scene():
		var movement_velocity: Vector2
		var direction = InputControlls.get_directional_vector().normalized()
		movement_velocity = direction
		return movement_velocity
	return Vector2.ZERO
