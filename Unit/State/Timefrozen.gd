extends UnitState

var previous_state: State

func enter(_data := {}) -> void:
	super()
	if owner.previous_state.name != "Disabled":
		previous_state = owner.previous_state
	unit.model_animation.pause()
	unit.casting_enabled = false
	
func exit() -> void:
	unit.casting_enabled = true
	unit.model_animation.play()

func get_unpause_state() -> String:
	return previous_state.name if previous_state != null else name
