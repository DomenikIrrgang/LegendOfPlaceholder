class_name Weapon
extends Node2D

@onready
var animation: AnimationPlayer = $Animation

func _ready() -> void:
	visible = false
	animation.animation_finished.connect(on_animation_finished)
	animation.animation_started.connect(on_animation_started)

func attack(player: Player) -> AnimationPlayer:
	return

func on_animation_finished(animation_name: String) -> void:
	visible = false
	
func on_animation_started(animation_name: String) -> void:
	visible = true
