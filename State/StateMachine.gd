class_name StateMachine
extends Node

signal transitioned(state_name: String)

@export
var initial_state: NodePath

@onready
var current_state: State = get_node(initial_state)

var enabled: bool = true

func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.set_state_machine(self)
	current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if enabled:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if enabled:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if enabled:
		current_state.physics_update(delta)

func has_state(state_name: String) -> bool:
	return has_node(state_name)
	
func can_transition_to_state(target_state_name: String) -> bool:
	return current_state.can_transition_to_state(get_node(target_state_name))

func transition_to(target_state_name: String, data: Dictionary = {}) -> void:
	assert(has_state(target_state_name), "State does not exist.")
	if not current_state.can_transition_to_state(get_node(target_state_name)):
		return
	current_state.exit()
	current_state = get_node(target_state_name)
	current_state.enter(data)
	#print("New State ", current_state.name)
	emit_signal("transitioned", current_state.name)
