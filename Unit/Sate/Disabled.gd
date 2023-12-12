extends UnitState

func enter(_data := {}) -> void:
	unit.casting_enabled = false
	unit.status_effect_updates_enabled = false
	update_animation()
	
func exit() -> void:
	unit.casting_enabled = true
	unit.status_effect_updates_enabled = true

func update_animation() -> void:
	match (unit.direction):
		Unit.Direction.LEFT:
			unit.set_animation("Idle_Left")
		Unit.Direction.RIGHT:
			unit.set_animation("Idle_Right")
		Unit.Direction.DOWN:
			unit.set_animation("Idle_Down")
		Unit.Direction.UP:
			unit.set_animation("Idle_Up")
