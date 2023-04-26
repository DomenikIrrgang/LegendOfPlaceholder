class_name DamageNumber
extends Node2D

@onready
var number_label: Label = $Number

@onready
var animation: AnimationPlayer = $Animation

func _ready() -> void:
	animation.animation_finished.connect(on_animation_finished)

func show_number(number: int) -> void:
	number_label.text = str(abs(number))
	animation.play("float_up")
	
func on_animation_finished(_animation_name: String) -> void:
	queue_free()
