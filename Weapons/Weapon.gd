class_name Weapon
extends Node2D

@onready
var animation: AnimationPlayer = $Animation

func _ready() -> void:
	visible = false
	animation.animation_finished.connect(on_animation_finished)
	animation.animation_started.connect(on_animation_started)

func attack(_player: Player) -> AnimationPlayer:
	return animation

func on_animation_finished(_animation_name: String) -> void:
	visible = false
	
func on_animation_started(_animation_name: String) -> void:
	visible = true
