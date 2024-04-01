class_name StateMachine
extends Node

signal transitioned(state_name: String)

@export
var initial_state: NodePath

var current_state: State

var enabled: bool = true

var previous_state: State

func _ready() -> void:
	await owner.ready
	current_state = get_child(0)
	for child in get_children():
		child.set_state_machine(self)
	if current_state != null:
		current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if enabled and current_state != null:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if enabled and current_state != null:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if enabled and current_state != null:
		current_state.physics_update(delta)

func has_state(state_name: String) -> bool:
	return has_node(state_name)
	
func is_in_state(state_name: String) -> bool:
	return current_state.name == state_name
	
func can_transition_to_state(target_state_name: String) -> bool:
	return current_state.can_transition_to_state(get_node(target_state_name))

func transition_to(target_state_name: String, data: Dictionary = {}) -> void:
	print("new state ", target_state_name)
	assert(has_state(target_state_name), "State does not exist.")
	if not current_state.can_transition_to_state(get_node(target_state_name)):
		return
	current_state.exit()
	previous_state = current_state
	current_state = get_node(target_state_name)
	current_state.enter(data)
	emit_signal("transitioned", current_state.name)
