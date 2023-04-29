class_name DamageNumber
extends Node2D

@onready
var number_label: Label = $Number

@onready
var animation: AnimationPlayer = $Animation

func _ready() -> void:
	animation.animation_finished.connect(on_animation_finished)

func show_number(result: AbilityCastResultEntry) -> void:
	match(result.hit_type):
		HitType.Enum.LANDED, HitType.Enum.CRITICAL:
			number_label.text = str(abs(result.value))
			if result.value < 0:
				number_label.self_modulate = Color(0.3, 1, 0.25, 1.0)
		HitType.Enum.DODGED:
			number_label.text = "dodge"
		HitType.Enum.PARRIED:
			number_label.text = "parry"
		HitType.Enum.MISSED:
			number_label.text = "miss"
		HitType.Enum.IMMUNE:
			number_label.text = "immune"
	animation.play("float_up")
	
func on_animation_finished(_animation_name: String) -> void:
	queue_free()
