extends Node

var original_velocity: Vector2
var current_velocity: Vector2

func _init(velocity: Vector2):
	original_velocity = velocity
	current_velocity = velocity

func _process(delta:float) -> void:
	pass
