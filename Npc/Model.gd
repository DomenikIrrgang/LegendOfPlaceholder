class_name Model
extends Node2D

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

func play(animation_name: String) -> void:
	print("starting animation", animation_name)
	assert(model_animation.has_animation(animation_name), "Model does not have animation '" + animation_name + "'")
	model_animation.play(animation_name)
	
func stop() -> void:
	model_animation.stop()
