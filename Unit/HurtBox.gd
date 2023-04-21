class_name HurtBox2D
extends Area2D

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: HitBox2D) -> void:
	if hitbox == null:
		return
	var pushback_strength = 150.0
	var hit_direction = hitbox.global_position.direction_to(global_position)
	owner.apply_pushback(hit_direction, pushback_strength, 0.3)
