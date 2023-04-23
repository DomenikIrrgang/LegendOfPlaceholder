extends HitBox2D

func on_hit(hurt_box: HurtBox2D) -> void:
	var unit = hurt_box.owner
	var pushback_strength = 10.0
	var hit_direction = global_position.direction_to(unit.global_position)
	unit.apply_pushback(hit_direction, pushback_strength, 0.3)
	unit.change_health(-100)
