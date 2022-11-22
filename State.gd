class_name State
extends Node

var state_machine = null

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_data := {}) -> void:
	pass

func exit() -> void:
	pass

func set_state_machine(new_state_machine) -> void:
	self.state_machine = new_state_machine

func get_transitions() -> Array[Node]:
	return get_children()
	
func can_transition_to_state(target_state: State) -> bool:
	for transition in get_transitions():
		if transition.target_state == target_state && transition.can_transition():
			return true
	return false
