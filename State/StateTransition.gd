class_name StateTransition
extends Node

@export
var target_state_path: NodePath

@onready
var source_state: State = get_parent()

@onready
var target_state: State = get_node(target_state_path) as State

func _ready() -> void:
	assert(target_state != null, "Transition has to have a target_state.")

func can_transition() -> bool:
	return true

func on_transition() -> void:
	pass
