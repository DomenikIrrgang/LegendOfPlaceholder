extends Ability

func execute(source: Unit, target: Unit) -> void:
	var pushback_strength = 0.2
	var hit_direction = source.global_position.direction_to(target.global_position)
	target.apply_pushback(hit_direction, pushback_strength, 0.3)
