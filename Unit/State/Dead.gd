extends UnitState

func enter(_data := {}) -> void:
	unit.casting_enabled = false
	unit.status_effect_updates_enabled = false
	update_animation()
	
func exit() -> void:
	unit.casting_enabled = true
	unit.status_effect_updates_enabled = true

func update_animation() -> void:
	unit.set_animation("Dead")
