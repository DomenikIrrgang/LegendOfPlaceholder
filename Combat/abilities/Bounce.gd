extends Ability

func execute(source: Unit, target: Unit) -> void:
	var pushback_strength = 0.1 + ((source.get_mass() / 50) * 0.05)
	var hit_direction = source.model.global_position.direction_to(target.model.global_position)
	target.apply_pushback(hit_direction, pushback_strength, 0.3)
